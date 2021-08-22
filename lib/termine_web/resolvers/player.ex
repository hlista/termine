defmodule TermineWeb.Resolvers.Player do
	alias Termine.Characters

	def create(params, _, %{context: %{current_user: current_user}}) do
		Characters.create_player(Map.put(params, :user_id, current_user.id))
	end

	def find(params, _), do: Characters.find_player(params)
end