defmodule Termine.Characters.Inventory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "inventories" do
    belongs_to :player, Termine.Characters.Player

  end

  def create_changeset(params) do
    changeset(%Termine.Characters.Inventory{}, params)
  end

  @doc false
  def changeset(inventory, attrs) do
    inventory
    |> cast(attrs, [:player_id])
    |> validate_required([:player_id])
  end
end
