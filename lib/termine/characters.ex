defmodule Termine.Characters do
	alias Termine.Repo
	alias Termine.Characters.{Player, Miner, Inventory, InventoryItem}
	alias EctoShorts.Actions

	def create_player(params) do
		Actions.create(Player, params)

	end

	def create_inventory(params) do
		Actions.create(Inventory, params)
	end

	def move_player(%{hash: hash, user: user}) do
		user = Repo.preload(user, [player: [location: [:neighbor_nodes]]])
		case move_is_valid?(user.player, hash) do
			{true, node} ->
				Actions.update(Player, user.player.id, %{location_id: node.id})
			_ ->
				{:error, "Cannot travel to that node"}
		end

	end

	def find_player(params) do
		Actions.find(Player, params)
	end

	defp move_is_valid?(player, hash) do
		Enum.reduce(player.location.neighbor_nodes, {false, nil}, 
			fn node, acc-> 
				if node.hash === hash do
					{true, node}
				else
					acc
				end
			end)
	end

end