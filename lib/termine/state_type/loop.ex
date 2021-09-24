defmodule Termine.StateType.Loop do
  use Ecto.Schema
  import Ecto.Changeset

  schema "state_type_loops" do
    belongs_to :state, Termine.Worlds.State
    belongs_to :go_to_state, Termine.Worlds.State

  end

  @doc false
  def changeset(loop, attrs) do
    loop
    |> cast(attrs, [])
    |> validate_required([])
  end
end
