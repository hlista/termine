defmodule TermineWeb.Schema.Queries.Node do
	use Absinthe.Schema.Notation

	alias TermineWeb.Resolvers

	object :node_queries do
		field :nodes, list_of(:node) do
			arg :hash, :string
			#middleware TermineWeb.AdminAuthentication
			resolve &Resolvers.Node.all/2
		end
	end
end