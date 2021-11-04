defmodule TermineWeb.Schema.Mutations.Neighbor do
  use Absinthe.Schema.Notation

  alias TermineWeb.Resolvers

  object :neighbor_mutations do
    field :create_neighbor, :neighbor do
      arg :node_one_id, non_null(:id)
      arg :node_two_id, non_null(:id)
      #middleware TermineWeb.AdminAuthentication
      resolve &Resolvers.Neighbor.create/2
    end
  end
end