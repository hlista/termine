defmodule Termine.Character.InventoryItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "inventory_items" do
    field :amount, :integer
    belongs_to :player, Termine.Character.Player
    belongs_to :resource, Termine.World.Resource

  end

  @doc false
  def changeset(inventory_item, attrs) do
    inventory_item
    |> cast(attrs, [:amount])
    |> validate_required([:amount])
  end
end
