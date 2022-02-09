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

  def generate_weights(events) do
    Enum.map_reduce(events, 0, fn {i_id, l_id, r_id, w}, acc -> {{i_id, l_id, r_id, w + acc}, w + acc} end)
  end

  def take_random_weighted_sample(_, 0, _) do
    []
  end

  def take_random_weighted_sample(events, reward, total_weight) do
    Enum.reduce(1..reward, [], fn _, acc ->
      random_number = :rand.uniform(total_weight)
      [Enum.find(events, fn {_, _, _, w} -> w >= random_number end) | acc]
    end)
  end

  def reward_players(events) do
    events
    |> Enum.frequencies_by(fn {inventory_id, _, resource_id, _} -> {inventory_id, resource_id} end)
    |> Enum.each(fn {{inventory_id, resource_id}, total} -> 
      Characters.add_item_to_inventory(inventory_id, resource_id, total)
    end)
  end

  def update_nodes_resource_amount(events) do
    events
    |> Enum.frequencies_by(fn {_, node_id, _, _} -> node_id end)
    |> Enum.reduce([], fn {node_id, total}, acc ->
      case NodeResourceCache.update_resource_amount(node_id, -1 * total) do
        0 -> [node_id | acc]
        _ -> acc
      end
    end)
  end
end