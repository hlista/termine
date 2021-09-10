defmodule TermineWeb.Schema.Mutations.State do
	use Absinthe.Schema.Notation

	alias TermineWeb.Resolvers

	object :state_mutations do
		field :create_state, :state do
			arg :history_text, non_null(:string)
			arg :inspect_text, non_null(:string)
			arg :resource_amount, non_null(:integer)
			arg :type, non_null(:state_type)
			arg :next_state_id, :id
			#middleware TermineWeb.AdminAuthentication
			resolve &Resolvers.State.create/3
		end
	end
end