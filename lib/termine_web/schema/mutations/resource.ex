defmodule TermineWeb.Schema.Mutations.Resource do
  use Absinthe.Schema.Notation

  alias TermineWeb.Resolvers

  object :resource_mutations do
    field :create_resource, :resource do
      arg :name, non_null(:string)
      #middleware TermineWeb.AdminAuthentication
      resolve &Resolvers.Resource.create/2
    end
  end
end