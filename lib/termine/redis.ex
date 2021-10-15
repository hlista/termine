defmodule Termine.Redis do

	def set_node_to_mining(node_id) do
		hash = "mining"
		field = node_id
		Redix.command(:redix, ["HSET", hash, field, 1])
	end

	def del_node_from_mining(node_id) do
		hash = "mining"
		field = node_id
		Redix.command(:redix, ["HDEL", hash, field])
	end

	def get_all_mining_nodes() do
		hash = "mining"
		{:ok, list} = Redix.command(:redix, ["HGETALL", hash])
		convert_redis_output_list_to_map(list)
	end

	def delete_player_miners_hits(node_id, miner_id) do
		hash = "node:" <> node_id <> ":hits"
		field = miner_id
		Redix.command(:redix, ["HDEL", hash, field])
	end
	
	def zero_player_miners_hits(node_id, miner_id) do
		hash = "node:" <> node_id <> ":hits"
		field = miner_id
		Redix.command(:redix, ["HSET", hash, field, 0])
	end

	def increment_player_miners_hits(node_id, miner_id) do
		hash = "node:" <> node_id <> ":hits"
		field = miner_id
		Redix.command(:redix, ["HINCRBY", hash, field, 1])
	end

	def get_all_player_miners_hits(node_id) do
		hash = "node:" <> node_id <> ":hits"
		{:ok, list} = Redix.command(:redix, ["HGETALL", hash])
		convert_redis_output_list_to_map(list)
	end

	def set_player_miners_inventory_id(player_miner_id, inventory_id) do
		hash = "player_miner:" <> player_miner_id
		field = "inventory_id"
		Redix.command(:redix, ["HSET", hash, field, inventory_id])
	end

	def set_player_miners_expertise(player_miner_id, resource_id, expertise_level) do
		hash = "player_miner:" <> player_miner_id
		field = "expertise:" <> resource_id
		Redix.command(:redix, ["HSET", hash, field, expertise_level])
	end

	def set_node_resource_amount(node_id, resource_id, amount) do
		hash = "node:" <> node_id
		Redix.command(:redix, ["HSET", hash, "resource_id", resource_id])
		Redix.command(:redix, ["HSET", hash, "amount", amount])
	end

	def decrement_node_amount(node_id, amount) do
		hash = "node:" <> node_id
		Redix.command(:redix, ["HINCRBY", hash, "amount", -1 * amount])
	end

	def get_player_miners_expertise(player_miner_id, resource_id) do
		hash = "player_miner:" <> player_miner_id
		field = "expertise:" <> resource_id
		{:ok, level} = Redix.command(:redix, ["HGET", hash, field])
		level
	end

	def get_player_miners_hits(node_id, miner_id) do
		hash = "node:" <> node_id
		field = "hits:" <> miner_id
		{:ok, hits} = Redix.command(:redix, ["HGET", hash, field])
		hits
	end

	def get_player_miners_inventory_id(player_miner_id) do
		hash = "player_miner:" <> player_miner_id
		{:ok, resource_id} = Redix.command(:redix, ["HGET", hash, "inventory_id"])
		resource_id
	end

	def get_nodes_resource_id(node_id) do
		hash = "node:" <> node_id
		{:ok, resource_id} = Redix.command(:redix, ["HGET", hash, "resource_id"])
		resource_id
	end

	defp convert_redis_output_list_to_map(list) do
		list
		|> Enum.chunk_every(2)
		|> Enum.map(fn [x, y] -> {x, y} end)
		|> Enum.into(%{})
	end
end