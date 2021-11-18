defmodule TermineWeb.Types.Player do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  object :inventory_item do
    field :resource, :resource, resolve: dataloader(Termine.Items)
    field :amount, :integer
  end

  object :inventory do
    field :inventory_items, list_of(:inventory_item), resolve: dataloader(Termine.Characters)
  end

  object :player do
    field :id, :id
    field :username, :string
    field :location, :node, resolve: dataloader(Termine.Worlds)
    field :player_miners, list_of(:player_miner), resolve: dataloader(Termine.Miners)
    field :inventory, :inventory, resolve: dataloader(Termine.Characters)
  end
end