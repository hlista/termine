defmodule Termine.Distributor.Impl do
	alias Termine.Worlds
	alias Termine.Characters
	
	def initialize_state() do
		{:ok, nodes} = Worlds.list_nodes(%{preload: [player_miners: [expertises: [], inventory: []], current_state: [state_type_collectable: []]]})
		nodes = Enum.reduce(nodes, [], fn node, acc -> 
			if node.current_state.type === :mineable or node.current_state.type === :attackable do
				create_cache_structure(node)
				[node | acc]
			else
				acc
			end
		end)
		%{nodes: nodes}
	end

	def create_cache_structure(node) do
		Redix.command(:redix, ["HSET", "node:" <> Integer.to_string(node.id), "resource_id", node.current_state.state_type_collectable.resource_id])
		Redix.command(:redix, ["HSET", "node:" <> Integer.to_string(node.id), "amount_left", node.current_state.state_type_collectable.amount])
		create_miner_cache_structure(node, node.player_miners, node.current_state.state_type_collectable.resource_id)
	end

	def create_miner_cache_structure(node, miners, resource_id) do
		miners
		|> Enum.each(fn miner ->
			Redix.command(:redix, ["HSET", "player_miner:" <> Integer.to_string(miner.id), "expertise:" <> Integer.to_string(resource_id), get_miner_expertise_level(miner, resource_id)])
			Redix.command(:redix, ["HSET", "player_miner:" <> Integer.to_string(miner.id), "inventory_id", miner.inventory.id])
			Redix.command(:redix, ["HSET", "node:" <> Integer.to_string(node.id), "hits:" <> Integer.to_string(miner.id), 0])
		end)
	end

	def get_miner_expertise_level(miner, resource_id) do
		Enum.find_value(miner.expertises, fn x -> if x.resource_id === resource_id, do: x.level end)
	end

	def increment_nodes_miners_hits(nodes) do
		Enum.each(nodes, fn node -> 
			Enum.each(node.player_miners, fn miner ->
				Redix.command(:redix, ["HINCRBY", "node:" <> Integer.to_string(node.id), "hits:" <> Integer.to_string(miner.id), 1])
			end)
		end)
	end

	def distribute(nodes) do
		nodes
		|> Enum.map(fn {id, node} ->
			{id, Map.update(node, :miners, %{}, fn miners -> calculate_miners_reward(miners, node.resource_id) end)}
		end)
		|> Enum.into(%{})
	end

	def calculate_miners_reward(miners, resource_id) do
		miners
		|> Enum.map(fn {id, miner} ->
			{id, Map.update(miner, :hits, 0, fn hits -> 
				Characters.add_item_to_inventory(miner.inventory_id, resource_id, calculate_reward(miner.expertise, hits))
				0
			end)}
		end)
		|> Enum.into(%{})
	end

	def calculate_reward(expertise_level, trials) do
		{numerator, denominator} = case expertise_level do
			1 -> {1, 87}
			2 -> {1, 61}
			3 -> {1, 43}
			4 -> {2, 61}
			5 -> {1, 20}
		end
		binomial(numerator, denominator, trials)
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