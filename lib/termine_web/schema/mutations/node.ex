defmodule TermineWeb.Schema.Mutations.Node do
	use Absinthe.Schema.Notation

	alias TermineWeb.Resolvers

	object :node_mutations do
		field :create_node, :node do
			arg :name, non_null(:string)
			middleware TermineWeb.AdminAuthentication
			resolve &Resolvers.Node.create/3
		end
	end
end