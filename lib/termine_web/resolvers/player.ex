defmodule TermineWeb.Resolvers.Player do
	alias Termine.Characters

	def create(_, params, %{context: %{current_user: current_user}}) do
		params = Map.put(params, :user_id, current_user.id)
		Characters.create_player(params)
	end

	def find(params, _), do: Characters.find_player(params)
end