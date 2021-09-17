defmodule TermineWeb.Resolvers.State do
	alias Termine.Worlds

	def create(_, params, _) do
		params = ids_to_integer(params)

		Worlds.create_state(params)
	end

	def update(_, %{id: id} = params, _) do
		params = ids_to_integer(params)
		id = String.to_integer(id)
		Worlds.update_state(id, Map.delete(params, :id))
	end

	defp ids_to_integer(params) do
		params
		|> Map.take([:next_state_id, :resource_id])
		|> Enum.reduce(params, fn {key, value}, acc -> Map.put(acc, key, String.to_integer(value)) end)
	end

end