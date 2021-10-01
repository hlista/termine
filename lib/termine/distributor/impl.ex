defmodule Termine.Distributor.Impl do

	alias Termine.Worlds
	
	def initialize_state() do
		{:ok, nodes} = Worlds.list_nodes(%{preload: [player_miners: [expertises: []], current_state: [state_type_collectable: []]]})
		nodes = Enum.reduce(nodes, %{}, fn node, acc -> 
			if node.state_type === :mineable or node.state_type === :attackable do
				Map.put(acc, node.id, create_cache_structure(node))
			else
				acc
			end
		end)
		%{nodes: nodes}
	end

	def create_cache_structure(node) do
		%{
			resource_id: node.current_state.state_type_collectable.resource_id,
			amount_left: node.current_state.state_type_collectable.amount,
			miners: create_miner_cache_structure(node.player_miners, node.current_state.state_type_collectable.resource_id)
		}
	end

	def create_miner_cache_structure(miners, resource_id) do
		miners
		|> Enum.map(fn miner -> 
			{miner.id, %{expertise: get_miner_expertise_level(miner, resource_id), hits: 0}}
		end)
		|> Enum.into(%{})
	end

	def get_miner_expertise_level(miner, resource_id) do
		Enum.find_value(miner.expertises, fn x -> if x.resource_id === resource_id, do: x.level end)
	end

	def increment_nodes_miners_hits(nodes) do
		nodes
		|> Enum.map(fn {id, node} ->
			{id, Map.update(node, :miners, %{}, fn current_value -> increment_miners_hits(current_value) end)}
		end)
		|> Enum.into(%{})
	end

	def increment_miners_hits(miners) do
		miners
		|> Enum.map(fn {id, miner} -> 
			{id, Map.update(miner, :hits, 0, fn current_value -> current_value + 1 end)}
		end)
		|> Enum.into(%{})
	end

end