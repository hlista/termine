defmodule Termine.Characters do
	alias Termine.Repo
	alias Termine.Characters.{Player, Miner, Inventory, InventoryItem, PlayerNodeHistory}
	alias EctoShorts.Actions

	def list_players(params) do
		{:ok, Actions.all(Player, params)}
	end

	def create_player(params) do
		Actions.create(Player, params)
	end

	def create_inventory(params) do
		Actions.create(Inventory, params)
	end

	def create_node_history(params) do
		Actions.create(PlayerNodeHistory, params)
	end

	def move_player(%{hash: hash, user: user}) do
		user = Repo.preload(user, [player: [location: [:neighbor_nodes], history_nodes: []]])
		valid_nodes = user.player.location.neighbor_nodes ++ user.player.history_nodes
		case find_valid_node(hash, valid_nodes) do
			nil ->
				{:error, "Cannot travel to that node"}
			node ->
				create_node_history(%{player_id: user.player.id, node_id: node.id})
				Actions.update(Player, user.player.id, %{location_id: node.id})
		end

	end

	def find_player(params) do
		Actions.find(Player, params)
	end

	defp find_valid_node(hash, nodes) do
		Enum.find(nodes, fn x -> x.hash === hash end)
	end

end