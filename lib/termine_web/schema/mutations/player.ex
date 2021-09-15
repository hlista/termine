defmodule TermineWeb.Schema.Mutations.Player do
	use Absinthe.Schema.Notation

	alias TermineWeb.Resolvers

	object :player_mutations do
		field :create_player, :player do
			arg :username, non_null(:string)

			resolve &Resolvers.Player.create/3
		end

		field :move_player, :player do
			arg :hash, non_null(:string)

			resolve &Resolvers.Player.move/3
		end
	end
end