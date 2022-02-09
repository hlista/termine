defmodule Termine.PlayerMinerProducerConsumerCalculateReward do
  use GenStage
  alias Termine.PlayerMinerTimestampCache
  alias Termine.NodeResourceCache
  alias Termine.RewardCalculator

  def start_link(_opts) do
    GenStage.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:consumer, %{}, subscribe_to: [{Termine.PlayerMinerProducer, max_demand: 20}]}
  end

  def handle_events(events, _from, state) do
    time = :os.system_time(:second)
    events = Enum.map(events, fn player_miner ->
      {player_miner.inventory.id, player_miner.location_id, NodeResourceCache.get_resource_id(player_miner.location_id), time - PlayerMinerTimestampCache.get_and_set(player_miner.id, time)}
    end)

    {weighted_array, total_weight} = RewardCalculator.generate_weights(events)

    reward = RewardCalculator.calculate_reward(total_weight)

    IO.inspect weighted_array
    IO.inspect reward

    events = RewardCalculator.take_random_weighted_sample(weighted_array, reward, total_weight)

    RewardCalculator.reward_players(events)

    nodes_out_of_resouces = RewardCalculator.update_nodes_resource_amount(events)

    {:noreply, [], state}
  end
end