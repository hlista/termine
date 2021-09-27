defmodule TermineWeb.Resolvers.State do
	alias Termine.Worlds
	alias Termine.StateTypes

	def all(params, _), do: Worlds.list_states(params)

	def create(%{type: :block} = params, _) do
		params = params
		|> ids_to_integer([:node_id])
		|> Map.delete(:state_type_object)

		Worlds.create_state(params)
	end

	def create(params, _) do
		params = ids_to_integer(params, [:node_id])

		Worlds.create_state(params)
	end

	def update(%{id: id} = params, _) do
		params = ids_to_integer(params, [:node_id])
		id = String.to_integer(id)
		Worlds.update_state(id, Map.delete(params, :id))
	end

	defp ids_to_integer(params, ids) do
		params
		|> Map.take(ids)
		|> Enum.reduce(params, fn {key, value}, acc -> Map.put(acc, key, String.to_integer(value)) end)
	end

end