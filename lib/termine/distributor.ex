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
		schedule_distribution()
		schedule_increment()
		{:ok, Impl.initialize_state()}
	end

	@impl true
	def handle_info(:increment, state) do
		schedule_increment()
		Impl.increment_nodes_miners_hits(state.nodes)
		{:noreply, state}
	end

	@impl true
	def handle_info(:distribute, state) do
		schedule_distribution()
		Impl.distribute(state.nodes)
		{:noreply, state}
	end

	defp schedule_increment() do
		Process.send_after(self(), :increment, 1000)
	end

	defp schedule_distribution() do
		Process.send_after(self(), :distribute, 60000)
	end
end