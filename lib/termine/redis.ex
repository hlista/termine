defmodule Termine.Redis do

  def push_mining_node(node_id) do
    list = "mining"
    redis_command(["LPUSH", list, node_id])
  end

  def del_node_from_mining(node_id) do
    list = "mining"
    redis_command(["LREM", list, 0, node_id])
  end

  def pop_mining_node() do
    list = "mining"
    {:ok, node_id} = redis_command(["RPOP", list])
    node_id
  end

  def lock_node_for_operation(node_id, operation, random_string, expire) do
    key = node_id <> ":" <> operation <> ":lock"
    redis_command(["SET", key, random_string, "NX", "PX", expire])
  end

  def release_node_for_operation(node_id, operation, random_string) do
    key = node_id <> ":" <> operation <> ":lock"
    {:ok, val} = redis_command(["GET", key])
    if val === random_string do
      redis_command(["DEL", key])
    end
  end

  def seconds_since_last_increment(node_id) do
    current_time = :os.system_time(:second)
    key = node_id <> ":increment:timestamp"
    {:ok, last_call} = redis_command(["SET", key, Integer.to_string(current_time), "EX", "30", "GET"])
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
    redis_command(["HDEL", hash, field])
  end
  
  def zero_player_miners_hits(node_id, miner_id) do
    hash = "node:" <> node_id <> ":hits"
    field = miner_id
    redis_command(["HSET", hash, field, 0])
  end

  def increment_player_miners_hits(node_id, miner_id, count) do
    hash = "node:" <> node_id <> ":hits"
    field = miner_id
    redis_command(["HINCRBY", hash, field, count])
  end

  def get_all_player_miners_hits(node_id) do
    hash = "node:" <> node_id <> ":hits"
    {:ok, list} = redis_command(["HGETALL", hash])
    convert_redis_output_list_to_map(list)
  end

  def set_player_miners_inventory_id(player_miner_id, inventory_id) do
    hash = "player_miner:" <> player_miner_id
    field = "inventory_id"
    redis_command(["HSET", hash, field, inventory_id])
  end

  def set_all_player_miners_expertises(player_miner_id, expertises) do
    hmset = Enum.reduce(expertises, [], fn expertise, acc -> 
      [Integer.to_string(expertise.resource_id) | [Integer.to_string(expertise.level) | acc]]
    end)
    hmset = ["HMSET" | ["player_miner:" <> player_miner_id <> ":expertise" | hmset]]
    redis_command(hmset)
  end

  def set_node_resource_amount(node_id, resource_id, amount) do
    hash = "node:" <> node_id
    redis_command(["HSET", hash, "resource_id", resource_id])
    redis_command(["HSET", hash, "amount", amount])
  end

  def decrement_node_amount(node_id, amount) do
    hash = "node:" <> node_id
    redis_command(["HINCRBY", hash, "amount", -1 * amount])
  end

  def get_node_amount(node_id) do
    hash = "node:" <> node_id
    {:ok, amount} = redis_command(["HGET", hash, "amount"])
    if (amount) do
      amount
    else
      0
    end
  end

  def get_player_miners_expertise(player_miner_id, resource_id) do
    hash = "player_miner:" <> player_miner_id <> ":expertise"
    field = resource_id
    {:ok, level} = redis_command(["HGET", hash, field])
    level
  end

  def get_player_miners_hits(node_id, miner_id) do
    hash = "node:" <> node_id
    field = "hits:" <> miner_id
    {:ok, hits} = redis_command(["HGET", hash, field])
    hits
  end

  def get_player_miners_inventory_id(player_miner_id) do
    hash = "player_miner:" <> player_miner_id
    {:ok, resource_id} = redis_command(["HGET", hash, "inventory_id"])
    resource_id
  end

  def get_nodes_resource_id(node_id) do
    hash = "node:" <> node_id
    {:ok, resource_id} = redis_command(["HGET", hash, "resource_id"])
    resource_id
  end

  defp convert_redis_output_list_to_map(list) do
    list
    |> Enum.chunk_every(2)
    |> Enum.map(fn [x, y] -> {x, y} end)
    |> Enum.into(%{})
  end

  defp redis_command(command_array) do
    :poolboy.transaction(:worker, fn pid -> GenServer.call(pid, {:command, command_array}) end)
  end
end