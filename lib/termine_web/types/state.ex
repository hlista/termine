defmodule TermineWeb.Types.State do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  enum :state_type, values: [:mineable, :attackable, :donatable, :block, :camp]

  object :state do
    field :id, :id
    field :inspect_text, :string
      field :type, :state_type
      field :node, :node, resolve: dataloader(Termine.Worlds)

      field :state_type_collectable, :state_type_collectable, resolve: dataloader(Termine.StateTypes)
  end

  object :state_type_collectable do
    field :amount, :integer
    field :resource_id, :id
  end

  input_object :input_state_type_collectable do
    field :amount, :integer
    field :resource_id, :id
  end

end