defmodule Termine.StateTypes.LoopUntil do
  use Ecto.Schema
  import Ecto.Changeset

  schema "state_type_loop_untils" do
    belongs_to :state, Termine.Worlds.State
    belongs_to :go_to_state, Termine.Worlds.State
    belongs_to :until_state, Termine.Worlds.State

  end

  def create_changeset(params) do
    changeset(%Termine.StateTypes.LoopUntil{}, params)
  end

  @doc false
  def changeset(loop_until, attrs) do
    loop_until
    |> cast(attrs, [:go_to_state_id, :until_state_id])
    |> validate_required([:go_to_state_id, :until_state_id])
  end
end
