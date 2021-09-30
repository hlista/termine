defmodule Termine.Miners do
	alias Termine.Repo
	alias Termine.Miners.{Miner, PlayerMiner, Expertise}
	alias EctoShorts.Actions

	def create_miner(params) do
		Actions.create(Miner, params)
	end
end