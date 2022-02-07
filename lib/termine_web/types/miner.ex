defmodule TermineWeb.Types.Miner do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  object :miner do
    field :id, :id
    field :name, :string
    field :description, :string
  end


  object :player_miner do
    field :id, :id
    field :miner, :miner, resolve: dataloader(Termine.Miners)
    field :location, :node, resolve: dataloader(Termine.Worlds)

  end
end