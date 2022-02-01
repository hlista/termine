defmodule Termine.RewardCalculator do
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
end