defmodule TermineWeb.Resolvers.Node do
	alias Termine.Worlds

	def create(params, _) do
		ids_to_integer(params)
		|> Map.put(:hash, generate_hash())
		|> Worlds.create_node()
	end

	def update(%{id: id} = params, _) do
		params = ids_to_integer(params)
		id = String.to_integer(id)
		Worlds.update_node(id, Map.delete(params, :id))
	end

	defp generate_hash() do
		for _ <- 1..6, into: "", do: <<Enum.random('0123456789abcdef')>>
	end

	defp ids_to_integer(params) do
		params
		|> Map.take([:state_id])
		|> Enum.reduce(params, fn {key, value}, acc -> Map.put(acc, key, String.to_integer(value)) end)
	end
end