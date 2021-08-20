defmodule TermineWeb.Resolvers.Player do
	alias TermineWeb.Characters

	def create(params, _), do: Characters.create_player(params)

end