defmodule Termine.Characters do
	alias Termine.Repo
	alias Termine.Characters.{Player, Miner, Inventory, InventoryItem}
	alias EctoShorts.Actions

	def create_player(params) do
		Actions.create(Player, params)
	end

	def find_player(params) do
		Actions.find(Player, params)
	end

	def create_inventory(params) do
		Actions.create(Inventory, params)
	end
end