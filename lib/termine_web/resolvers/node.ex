defmodule TermineWeb.Resolvers.Node do
	alias Termine.Worlds

	def create(_, params, _) do
		Map.put(params, :hash, generate_hash())
		|> Worlds.create_node()
	end

	defp generate_hash() do
		for _ <- 1..6, into: "", do: <<Enum.random('0123456789abcdef')>>
	end
end