defmodule TermineWeb.Resolvers.State do
	alias Termine.Worlds

	def create(_, params, _) do
		Worlds.create_state(params)
	end
end