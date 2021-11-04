defmodule TermineWeb.Types.Node do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  object :node do
    field :id, :id
    field :name, :string
    field :hash, :string
    field :intro_text, :string
    field :current_state, :state, resolve: dataloader(Termine.Worlds)
    field :state_id_array, list_of(:id)
    field :states, list_of(:state), resolve: dataloader(Termine.Worlds)
  end
end