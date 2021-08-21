defmodule TermineWeb.Resolvers.Player do
	alias TermineWeb.Characters

	def create(params, _), do: Characters.create_player(params)

	def find(params, _), do: Characters.find_player(params)
end