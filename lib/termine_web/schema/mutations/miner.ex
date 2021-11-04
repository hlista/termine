defmodule TermineWeb.Schema.Mutations.Miner do
  use Absinthe.Schema.Notation

  alias TermineWeb.Resolvers

  object :miner_mutations do
    field :create_miner, :miner do
      arg :name, non_null(:string)
      arg :description, non_null(:string)
      #middleware TermineWeb.AdminAuthentication
      resolve &Resolvers.Miner.create/2
    end

    field :send_player_miner, :player_miner do
      arg :id, non_null(:id)
      resolve &Resolvers.Miner.send/2
    end
  end
end