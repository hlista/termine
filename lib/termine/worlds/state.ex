defmodule Termine.Worlds.State do
  use Ecto.Schema
  import Ecto.Changeset

  schema "states" do
    field :inspect_text, :string
    field :type, Ecto.Enum, values: [:mineable, :attackable, :donatable, :block, :camp]
    belongs_to :node, Termine.Worlds.Node

    has_one :state_type_collectable, Termine.StateTypes.Collectable

  end

  def create_changeset(params) do
    changeset(%Termine.Worlds.State{}, params)
  end

  @doc false
  def changeset(state, attrs) do
    state
    |> cast(attrs, [:inspect_text, :type, :node_id])
    |> validate_required([:inspect_text, :type])
    |> cast_assoc(:state_type_collectable) 
  end
end
