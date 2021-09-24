defmodule TermineWeb.Schema.Mutations.State do
	use Absinthe.Schema.Notation

	alias TermineWeb.Resolvers

	object :state_mutations do
		field :create_state, :state do
			arg :history_text, non_null(:string)
			arg :inspect_text, non_null(:string)
			arg :resource_amount, non_null(:integer)
			arg :type, non_null(:state_type)
			arg :node_id, non_null(:id)
			arg :resource_id, :id
			#middleware TermineWeb.AdminAuthentication
			resolve &Resolvers.State.create/2
		end

		field :update_state, :state do
			arg :id, non_null(:id)
			arg :history_text, :string
			arg :inspect_text, :string
			arg :resource_amount, :integer
			arg :type, :state_type
			arg :node_id, :id
			arg :resource_id, :id
			#middleware TermineWeb.AdminAuthentication
			resolve &Resolvers.State.update/2
		end
	end
end