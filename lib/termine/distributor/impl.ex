defmodule Termine.Distributor.Impl do

	alias Termine.Worlds
	
	def initialize_state() do
		{:ok, nodes} = Worlds.list_nodes(%{preload: [miners: [], current_state: [state_type_collectable: [:resource]]]})
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
			resource: node.current_state.state_type_collectable.resource,
			amount_left: node.current_state.state_type_collectable.amount,
			miners: create_miner_cache_structure(node.miners)
		}
	end

	def create_miner_cache_structure(miners) do
		miners
		|> Enum.map(fn miner -> 
			{miner.id, %{expertise: 1, hits: 0}}
		end)
		|> Enum.into(%{})
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