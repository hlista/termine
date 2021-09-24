defmodule Termine.StateType.LoopUntil do
  use Ecto.Schema
  import Ecto.Changeset

  schema "state_type_loop_untils" do
    belongs_to :state, Termine.Worlds.State
    belongs_to :go_to_state, Termine.Worlds.State
    belongs_to :until_state, Termine.Worlds.State

  end

  @doc false
  def changeset(loop_until, attrs) do
    loop_until
    |> cast(attrs, [])
    |> validate_required([])
  end
end
