defmodule TermineWeb.Resolvers.Miner do
	alias Termine.Miners

	def create(params, _) do
		Miners.create_miner(params)
	end
end