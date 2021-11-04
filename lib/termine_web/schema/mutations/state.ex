defmodule TermineWeb.Schema.Mutations.State do
  use Absinthe.Schema.Notation

  alias TermineWeb.Resolvers

  object :state_mutations do
    field :create_state, :state do
      arg :inspect_text, non_null(:string)
      arg :type, non_null(:state_type)
      arg :node_id, non_null(:id)
      arg :state_type_collectable, :input_state_type_collectable
      arg :state_type_loop_until, :input_state_type_loop_until
      arg :state_type_loop, :input_state_type_loop
      arg :state_type_block_until, :input_state_type_block_until
      #middleware TermineWeb.AdminAuthentication
      resolve &Resolvers.State.create/2
    end

    field :update_state, :state do
      arg :id, non_null(:id)
      arg :inspect_text, :string
      arg :node_id, :id
      #middleware TermineWeb.AdminAuthentication
      resolve &Resolvers.State.update/2
    end

    field :update_state_type, :state do
      arg :state_id, non_null(:id)
      arg :type, :state_type
      arg :state_type_collectable, :input_state_type_collectable
      arg :state_type_loop_until, :input_state_type_loop_until
      arg :state_type_loop, :input_state_type_loop
      arg :state_type_block_until, :input_state_type_block_until
      #middleware TermineWeb.AdminAuthentication
      resolve &Resolvers.State.update_type/2
    end
  end
end