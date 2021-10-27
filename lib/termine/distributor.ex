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
		state = Impl.initialize_state()
		Enum.each(state, fn {node_id, _} -> schedule_increment(node_id) end)
		schedule_distribution()
		{:ok, state}
	end

	@impl true
	def handle_info({:increment, node_id}, state) do
		task = Task.Supervisor.async_nolink(Termine.TaskSupervisor, fn ->
			{:incremented, Impl.increment_nodes_miners_hits(node_id)}
		end)

		{:noreply, state}
	end

	@impl true
	def handle_info({ref, {:incremented, node_id}}, state) do
		Process.demonitor(ref, [:flush])
		schedule_increment(node_id)
		{:noreply, state}
	end

	@impl true
	def handle_info(:distribute, state) do
		schedule_distribution()
		Impl.distribute()
		{:noreply, state}
	end

	defp schedule_increment(node_id) do
		Process.send_after(self(), {:increment, node_id}, 1000)
	end

	defp schedule_distribution() do
		Process.send_after(self(), :distribute, 60000)
	end
end