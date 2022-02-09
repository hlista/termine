defmodule Termine.PlayerMinerProducer do
  use GenStage
  alias Termine.Miners

  def start_link(_opts) do
    GenStage.start_link(__MODULE__, 0, name: __MODULE__)
  end

  def init(_opts) do
    schedule_refresh()
    {:producer, 0}
  end

  def handle_info(:refresh, pending) do
    schedule_refresh()
    if (pending > 0) do
      dispatch_events(pending)
    else
      {:noreply, [], pending}
    end
  end

  def handle_demand(demand, pending) do
    dispatch_events(pending + demand)
  end

  defp dispatch_events(demand) do
    {:ok, events} = Miners.get_player_miners_for_mining(demand)
    size = Enum.count(events)
    {:noreply, events, demand - size}
  end

  defp schedule_refresh() do
    Process.send_after(self(), :refresh, 1000)
  end
end