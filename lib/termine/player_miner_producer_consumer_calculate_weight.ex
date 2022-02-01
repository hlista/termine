defmodule Termine.PlayerMinerProducerConsumerCalculateWeight do
  use GenStage
  alias Termine.PlayerMinerTimestampCache

  def start_link(_opts) do
    GenStage.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:producer_consumer, %{}, subscribe_to: [{Termine.PlayerMinerProducer, max_demand: 20}]}
  end

  def handle_events(events, _from, state) do
    time = :os.system_time(:second)
    events = Enum.map(events, fn player_miner ->
      %{player_id: player_miner.player_id, location_id: player_miner.location_id, weight: time - PlayerMinerTimestampCache.get_and_set(player_miner.id, time)}
    end)
    {:noreply, events, state}
  end
end