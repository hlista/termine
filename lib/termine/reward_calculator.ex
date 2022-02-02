defmodule Termine.RewardCalculator do
  alias Termine.Characters
  alias Termine.NodeResourceCache

  def calculate_reward(trials) do
    binomial(1, 40, trials)
  end

  def binomial(numerator, denominator, trials) do
    random_number = :rand.uniform()
    probability_0 = :math.pow((denominator - numerator) / denominator, trials)
    calculate_successes(0, random_number, probability_0, probability_0, numerator, denominator, trials)
  end

  def calculate_successes(n, rand, accumulated_probability, _, _, _, _) when rand < accumulated_probability do
    n
  end

  def calculate_successes(n, rand, accumulated_probability, probability, numerator, denominator, trials) do
    new_probability = probability * (numerator * (trials - n)) / ((denominator - numerator) * (n + 1))
    calculate_successes(n + 1, rand, accumulated_probability + new_probability, new_probability, numerator, denominator, trials)
  end

  def take_random_weighted_sample(events, reward) do
    events
    |> Enum.map(fn {inventory_id, node_id, resource_id, weight} -> 
      List.duplicate({inventory_id, node_id, resource_id}, weight)
    end)
    |> List.flatten()
    |> Enum.take_random(reward)
  end

  def reward_players(events) do
    events
    |> Enum.frequencies_by(fn {inventory_id, _, resource_id} -> {inventory_id, resource_id} end)
    |> Enum.each(fn {{inventory_id, resource_id}, total} -> 
      Characters.add_item_to_inventory(inventory_id, resource_id, total)
    end)
  end

  def update_nodes_resource_amount(events) do
    events
    |> Enum.frequencies_by(fn {_, node_id, _} -> node_id end)
    |> Enum.reduce([], fn {node_id, total}, acc ->
      case NodeResourceCache.update_resource_amount(node_id, -1 * total) do
        0 -> [node_id | acc]
        _ -> acc
      end
    end)
  end
end