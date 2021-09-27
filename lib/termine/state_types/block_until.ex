defmodule Termine.StateTypes.BlockUntil do
  use Ecto.Schema
  import Ecto.Changeset

  schema "state_type_block_untils" do
    belongs_to :state, Termine.Worlds.State
    belongs_to :until_state, Termine.Worlds.State

  end

  def create_changeset(params) do
    changeset(%Termine.StateTypes.BlockUntil{}, params)
  end

  @doc false
  def changeset(block_until, attrs) do
    block_until
    |> cast(attrs, [:state_id, :until_state_id])
    |> validate_required([:state_id, :until_state_id])
  end
end
