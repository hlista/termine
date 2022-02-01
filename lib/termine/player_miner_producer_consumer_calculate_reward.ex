defmodule Termine.PlayerMinerProducerConsumerCalculateReward do
  use GenStage
  alias Termine.RewardCalculator

  def start_link(_opts) do
    GenStage.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:producer_consumer, %{}, subscribe_to: [{Termine.PlayerMinerProducerConsumerCalculateWeight, max_demand: 20}]}
  end

  def handle_event(events, _from, state) do
    total_weight = Enum.reduce(events, 0, fn %{weight: weight}, acc -> acc + weight end)
    reward = RewardCalculator.calculate_reward(total_weight)

    events = events
    |> Enum.map(fn %{player_id: p_id, location_id: l_id, weight: weight} -> 
      List.duplicate({p_id, l_id}, weight)
    end)
    |> List.flatten()
    |> Enum.take_random(reward)
    |> Enum.frequencies()
    |> Enum.to_list()
    {:noreply, events, state}
  end
end