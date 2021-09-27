defmodule Termine.Worlds.State do
  use Ecto.Schema
  import Ecto.Changeset

  schema "states" do
    field :inspect_text, :string
    field :type, Ecto.Enum, values: [:mineable, :attackable, :donatable, :block, :block_until, :loop, :loop_until]
    belongs_to :node, Termine.Worlds.Node

    has_one :state_type_collectable, Termine.StateTypes.Collectable
    has_one :state_type_block_until, Termine.StateTypes.BlockUntil
    has_one :state_type_loop, Termine.StateTypes.Loop
    has_one :state_type_loop_until, Termine.StateTypes.LoopUntil

  end

  def create_changeset(params) do
    changeset(%Termine.Worlds.State{}, params)
  end

  @doc false
  def changeset(state, attrs) do
    state
    |> cast(attrs, [:inspect_text, :type, :node_id])
    |> validate_required([:inspect_text, :type])
  end
end
