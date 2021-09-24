defmodule Termine.StateType.BlockUntil do
  use Ecto.Schema
  import Ecto.Changeset

  schema "state_type_block_untils" do
    belongs_to :state, Termine.Worlds.State
    belongs_to :until_state, Termine.Worlds.State

  end

  @doc false
  def changeset(block_until, attrs) do
    block_until
    |> cast(attrs, [])
    |> validate_required([])
  end
end
