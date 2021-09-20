defmodule TermineWeb.Schema.Queries.Player do
	use Absinthe.Schema.Notation

	alias TermineWeb.Resolvers

	object :player_queries do
		field :players, list_of(:player) do
			arg :username, :string
			arg :location_id, :id
			arg :user_id, :id
			#middleware TermineWeb.AdminAuthentication
			resolve &Resolvers.Player.all/2
		end
	end
end