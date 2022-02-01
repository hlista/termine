defmodule Termine.PlayerMinerProducer do
  use GenStage
  alias Termine.Miners

  def start_link(_opts) do
    GenStage.start_link(__MODULE__, 0, name: __MODULE__)
  end

  def init(_opts) do
    schedule_refresh()
    {:producer, {0, 0}}
  end

  def handle_info(:refresh, {offset, pending}) do
    schedule_refresh()
    if (pending > 0) do
      dispatch_events(0, pending)
    else
      {:noreply, [], {offset, pending}}
    end
  end

  def handle_demand(demand, {offset, pending}) do
    dispatch_events(offset, pending + demand)
  end

  defp dispatch_events(offset, demand) do
    {:ok, events} = Miners.list_player_miners_currently_mining(%{offset: offset, limit: demand, preload: :inventory})
    size = Enum.count(events)
    {:noreply, events, {offset + size, demand - size}}
  end

  defp schedule_refresh() do
    Process.send_after(self(), :refresh, 1000)
  end
end