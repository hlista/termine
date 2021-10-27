defmodule Termine.Distributor.Impl do
	alias Termine.Worlds
	alias Termine.Characters
	alias Termine.Redis
	
	def initialize_state() do
		{:ok, nodes} = Worlds.list_nodes(%{preload: [player_miners: [expertises: [], inventory: []], current_state: [state_type_collectable: []]]})
		Enum.each(nodes, fn node -> 
			if node.current_state.type === :mineable or node.current_state.type === :attackable do
				create_cache_structure(node)
			end
		end)
		Enum.reduce(nodes, %{}, fn node, acc -> Map.put(acc, Integer.to_string(node.id), {nil, nil}) end)
	end

	def create_cache_structure(node) do
		Redis.set_node_resource_amount(Integer.to_string(node.id), node.current_state.state_type_collectable.resource_id, node.current_state.state_type_collectable.amount)
		Redis.set_node_to_mining(Integer.to_string(node.id))
		create_miner_cache_structure(node, node.player_miners, node.current_state.state_type_collectable.resource_id)
	end

	def create_miner_cache_structure(node, miners, resource_id) do
		miners
		|> Enum.each(fn miner ->
			Redis.set_player_miners_expertise(Integer.to_string(miner.id), Integer.to_string(resource_id), get_miner_expertise_level(miner, resource_id))
			Redis.set_player_miners_inventory_id(Integer.to_string(miner.id), miner.inventory.id)
			Redis.zero_player_miners_hits(Integer.to_string(node.id), Integer.to_string(miner.id))
		end)
	end

	def get_miner_expertise_level(miner, resource_id) do
		Enum.find_value(miner.expertises, fn x -> if x.resource_id === resource_id, do: x.level end)
	end

	def increment_nodes_miners_hits(node_id) do
		random_string = random_string()
		{:ok, val} = Redis.get_node_for_operation(node_id, "increment", random_string, "1000")
		if (!is_nil(val)) do
			count = Redis.seconds_since_last_increment(node_id)
			player_miner_map = Redis.get_all_player_miners_hits(node_id)
			Enum.each(player_miner_map, fn {player_miner_id, _} ->
				Redis.increment_player_miners_hits(node_id, player_miner_id, count)
			end)
			Redis.release_node_for_operation(node_id, "increment", random_string)
		end
	end

	def distribute() do
		nodes = Redis.get_all_mining_nodes()
		Enum.each(nodes, fn {node_id, _} ->
			player_miner_map = Redis.get_all_player_miners_hits(node_id)
			Enum.each(player_miner_map, fn {player_miner_id, hits} ->
				resource_id = Redis.get_nodes_resource_id(node_id)
				expertise_level = Redis.get_player_miners_expertise(player_miner_id, resource_id)
				inventory_id = Redis.get_player_miners_inventory_id(player_miner_id)
				reward = calculate_reward(String.to_integer(expertise_level), String.to_integer(hits))
				Characters.add_item_to_inventory(String.to_integer(inventory_id), String.to_integer(resource_id), reward)
				Redis.zero_player_miners_hits(node_id, player_miner_id)
				Redis.decrement_node_amount(node_id, reward)
			end)
			if (Redis.get_node_amount(node_id) <= 0) do
				Worlds.complete_state(node_id)
			end
		end)
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

	def random_string() do
		:crypto.strong_rand_bytes(10) |> Base.url_encode64 |> binary_part(0, 10)
	end

end