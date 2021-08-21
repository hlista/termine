defmodule TermineWeb.Schema.Queries.Player do
	use Absinthe.Schema.Notation

	alias TermineWeb.Resolvers

	object :player_queries do
		field :player, :player do
			arg :username, non_null(:string)

			resolve &Resolvers.Player.find/2
		end
	end
end