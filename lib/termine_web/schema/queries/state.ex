defmodule TermineWeb.Schema.Queries.State do
  use Absinthe.Schema.Notation

  alias TermineWeb.Resolvers

  object :state_queries do
    field :states, list_of(:state) do
      arg :type, :state_type
      arg :resource_id, :id
      middleware TermineWeb.AdminAuthentication
      resolve &Resolvers.State.all/2
    end
  end
end