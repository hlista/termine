defmodule Termine.StateTypes.Loop do
  use Ecto.Schema
  import Ecto.Changeset

  schema "state_type_loops" do
    belongs_to :state, Termine.Worlds.State
    belongs_to :go_to_state, Termine.Worlds.State

  end

  def create_changeset(params) do
    changeset(%Termine.StateTypes.Loop{}, params)
  end

  @doc false
  def changeset(loop, attrs) do
    loop
    |> cast(attrs, [:go_to_state_id])
    |> validate_required([:go_to_state_id])
  end
end
