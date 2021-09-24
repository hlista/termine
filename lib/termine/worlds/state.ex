defmodule Termine.Worlds.State do
  use Ecto.Schema
  import Ecto.Changeset

  schema "states" do
    field :history_text, :string
    field :inspect_text, :string
    field :type, Ecto.Enum, values: [:mineable, :attackable, :donatable, :block, :block_until, :loop, :loop_until]
    belongs_to :node, Termine.Worlds.Node

    has_one :state_type_collectable, Termine.StateType.Collectable
    has_one :state_type_block_until, Termine.StateType.BlockUntil
    has_one :state_type_loop, Termine.StateType.Loop
    has_one :state_type_loop_until, Termine.StateType.LoopUntil

  end

  def create_changeset(params) do
    changeset(%Termine.Worlds.State{}, params)
  end

  @doc false
  def changeset(state, attrs) do
    state
    |> cast(attrs, [:history_text, :inspect_text, :resource_amount, :type, :resource_id, :node_id])
    |> validate_required([:history_text, :inspect_text, :resource_amount, :type])
  end
end
