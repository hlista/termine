defmodule TermineWeb.Resolvers.State do
	alias Termine.Worlds

	def create(_, params, _) do
		params  = case params do
			%{next_state_id: id} -> %{params | next_state_id: String.to_integer(id)}
			_ -> params
		end
		Worlds.create_state(params)
	end
end