defmodule TermineWeb.Schema.Mutations.Node do
	use Absinthe.Schema.Notation

	alias TermineWeb.Resolvers

	object :node_mutations do
		field :create_node, :node do
			arg :name, non_null(:string)
			arg :intro_text, :string
			middleware TermineWeb.AdminAuthentication
			resolve &Resolvers.Node.create/3
		end
	end
end