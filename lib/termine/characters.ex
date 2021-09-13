defmodule Termine.Characters do
	alias Termine.Repo
	alias Termine.Characters.{Player, Miner, Inventory, InventoryItem}
	alias EctoShorts.Actions

	def create_player(%{user_id: user_id, username: username}) do
		changeset = Player.changeset(%Player{user_id: user_id}, %{username: username})
		case Repo.insert changeset do
			{:ok, player} ->
				create_inventory(player.id)
				{:ok, player}
			_ ->
				{:error, "Cannot create Player"}
		end
	end

	def find_player(params) do
		Actions.find(Player, params)
	end

	def preload_player_into_user(user) do
		Repo.preload(user, :player)
	end

	defp create_inventory(player_id) do
		changeset = Inventory.changeset(%Inventory{player_id: player_id}, %{})
		Repo.insert changeset
	end
end