defmodule TermineWeb.Schema.Mutations.State do
	use Absinthe.Schema.Notation

	alias TermineWeb.Resolvers

	object :state_mutations do
		field :create_state, :state do
			arg :inspect_text, non_null(:string)
			arg :type, non_null(:state_type)
			arg :state_type_object, non_null(:input_state_type_object)
			arg :node_id, non_null(:id)
			#middleware TermineWeb.AdminAuthentication
			resolve &Resolvers.State.create/2
		end

		field :update_state, :state do
			arg :id, non_null(:id)
			arg :inspect_text, :string
			arg :type, :state_type
			arg :state_type_object, :input_state_type_object
			arg :node_id, :id
			#middleware TermineWeb.AdminAuthentication
			resolve &Resolvers.State.update/2
		end
	end
end