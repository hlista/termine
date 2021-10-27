defmodule Termine.Redis do

	def push_mining_node(node_id) do
		list = "mining"
		Redix.command(:redix, ["LPUSH", list, node_id])
	end

	def del_node_from_mining(node_id) do
		list = "mining"
		Redix.command(:redix, ["LREM", list, 0, node_id])
	end

	def pop_mining_node() do
		list = "mining"
		{:ok, node_id} = Redix.command(:redix, ["RPOP", list])
		node_id
	end

	def lock_node_for_operation(node_id, operation, random_string, expire) do
		key = node_id <> ":" <> operation <> ":lock"
		Redix.command(:redix, ["SET", key, random_string, "NX", "PX", expire])
	end

	def release_node_for_operation(node_id, operation, random_string) do
		key = node_id <> ":" <> operation <> ":lock"
		{:ok, val} = Redix.command(:redix, ["GET", key])
		if val === random_string do
			Redix.command(:redix, ["DEL", key])
		end
	end

	def seconds_since_last_increment(node_id) do
		current_time = :os.system_time(:second)
		key = node_id <> ":increment:timestamp"
		{:ok, last_call} = Redix.command(:redix, ["GETSET", key, Integer.to_string(current_time)])
		if (last_call) do
			current_time - String.to_integer(last_call)
		else
			1
		end
	end

	def set_player_miner_to_mining(node_id, miner_id, expertises, inventory_id) do
		set_all_player_miners_expertises(miner_id, expertises)
		set_player_miners_inventory_id(miner_id, inventory_id)
		zero_player_miners_hits(node_id, miner_id)
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

	def increment_player_miners_hits(node_id, miner_id, count) do
		hash = "node:" <> node_id <> ":hits"
		field = miner_id
		Redix.command(:redix, ["HINCRBY", hash, field, count])
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

	def set_all_player_miners_expertises(player_miner_id, expertises) do
		hmset = Enum.reduce(expertises, [], fn expertise, acc -> 
			[Integer.to_string(expertise.resource_id) | [Integer.to_string(expertise.level) | acc]]
		end)
		hmset = ["HMSET" | ["player_miner:" <> player_miner_id <> ":expertise" | hmset]]
		Redix.command(:redix, hmset)
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

	def get_node_amount(node_id) do
		hash = "node:" <> node_id
		{:ok, amount} = Redix.command(:redix, ["HGET", hash, "amount"])
		amount
	end

	def get_player_miners_expertise(player_miner_id, resource_id) do
		hash = "player_miner:" <> player_miner_id <> ":expertise"
		field = resource_id
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