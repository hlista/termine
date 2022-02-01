defmodule Termine.PlayerMinerProducerConsumerCalculateReward do
  use GenStage
  alias Termine.PlayerMinerTimestampCache
  alias Termine.NodeResourceCache
  alias Termine.RewardCalculator

  def start_link(_opts) do
    GenStage.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:producer_consumer, %{}, subscribe_to: [{Termine.PlayerMinerProducer, max_demand: 20}]}
  end

  def handle_events(events, _from, state) do
    time = :os.system_time(:second)
    events = Enum.map(events, fn player_miner ->
      {player_miner.inventory.id, player_miner.location_id, NodeResourceCache.get_resource_id(player_miner.location_id), time - PlayerMinerTimestampCache.get_and_set(player_miner.id, time)}
    end)

    total_weight = Enum.reduce(events, 0, fn {_, _, _, weight}, acc -> acc + weight end)
    reward = RewardCalculator.calculate_reward(total_weight)

    events = RewardCalculator.take_random_weighted_sample(events, reward)

    RewardCalculator.reward_players(events)

    nodes_out_of_resouces = RewardCalculator.update_nodes_resource_amount(events)

    {:noreply, nodes_out_of_resouces, state}
  end
end