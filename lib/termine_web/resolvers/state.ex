defmodule TermineWeb.Resolvers.State do
	alias Termine.Worlds

	def create(_, params, _) do
		params = stringify_ids(params)

		Worlds.create_state(params)
	end

	def update(_, %{id: id} = params, _) do
		params = stringify_ids(params)
		id = String.to_integer(id)
		Worlds.update_state(id, Map.delete(params, :id))
	end

	defp stringify_ids(params) do
		params 
		|> case do
			%{next_state_id: id} -> %{params | next_state_id: String.to_integer(id)}
			_ -> params
		end
		|> case do
			%{resource_id: id} -> %{params | resource_id: String.to_integer(id)}
			_ -> params
		end
	end

end