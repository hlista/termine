defmodule Termine.Distributor do
	use GenServer

	alias Termine.Distributor.Impl

	@default_name __MODULE__

	def start_link(opts \\ []) do
		state = Keyword.get(opts, :state, %{})
		opts = Keyword.put_new(opts, :name, @default_name)

		GenServer.start_link(__MODULE__, state, opts)
	end

	@impl true
	def init(state) do
		Impl.initialize_state()
		schedule_next_node_immediately()
		{:ok, %{}}
	end

	@impl true
	def handle_cast({:increment_state, node_id}, state) do
		Impl.increment_state(node_id)
		{:noreply, state}
	end

	@impl true
	def handle_info({ref, {:incremented, _}}, state) do
		Process.demonitor(ref, [:flush])
		{:noreply, state}
	end

	@impl true
	def handle_info({ref, {:distributed, _}}, state) do
		Process.demonitor(ref, [:flush])
		{:noreply, state}
	end

	@impl true
	def handle_info(:next_node_work, state) do
		node_id = Termine.Redis.pop_mining_node()
		if (node_id) do
			Task.Supervisor.async_nolink(Termine.TaskSupervisor, fn ->
				{:incremented, Impl.increment_node(node_id)}
			end)
			Task.Supervisor.async_nolink(Termine.TaskSupervisor, fn ->
				{:distributed, Impl.distribute_node(node_id)}
			end)
			schedule_next_node_immediately()
			schedule_node_push(node_id)
		else
			schedule_next_node()
		end
		{:noreply, state}
	end

	@impl true
	def handle_info({:push_node_to_mining, node_id}, state) do
		is_node_mining = Termine.Worlds.is_node_mining(node_id)
		is_node_out_of_resource = (Redis.get_node_amount(node_id) <= 0)
		cond do
			is_node_mining and is_node_out_of_resource ->
				Impl.increment_state(node_id)
				Impl.initialize_node_for_mining(node_id)
				Termine.Redis.push_mining_node(node_id)
			is_node_mining ->
				Termine.Redis.push_mining_node(node_id)
		end
		{:noreply, state}
	end

	defp schedule_next_node_immediately() do
		send(self(), :next_node_work)
	end

	defp schedule_next_node() do
		Process.send_after(self(), :next_node_work, 1000)
	end

	defp schedule_node_push(node_id) do
		Process.send_after(self(), {:push_node_to_mining, node_id}, 1000)
	end
end