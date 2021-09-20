defmodule TermineWeb.Schema.Mutations.Node do
	use Absinthe.Schema.Notation

	alias TermineWeb.Resolvers

	object :node_mutations do
		field :create_node, :node do
			arg :name, non_null(:string)
			arg :intro_text, non_null(:string)
			arg :state_id, :id
			#middleware TermineWeb.AdminAuthentication
			resolve &Resolvers.Node.create/2
		end

		field :update_node, :node do
			arg :id, non_null(:id)
			arg :intro_text, :string
			arg :name, :string
			arg :state_id, :id
			#middleware TermineWeb.AdminAuthentication
			resolve &Resolvers.Node.update/2
		end
	end
end