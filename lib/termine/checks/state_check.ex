defmodule Termine.Checks.StateCheck do
  use Ecto.Schema
  import Ecto.Changeset

  schema "state_checks" do
    belongs_to :check, Termine.Checks.Check
    belongs_to :state, Termine.Worlds.State

  end

  @doc false
  def changeset(state_check, attrs) do
    state_check
    |> cast(attrs, [])
    |> validate_required([])
  end
end
