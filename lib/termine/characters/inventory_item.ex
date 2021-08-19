defmodule Termine.Characters.InventoryItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "inventory_items" do
    belongs_to :inventory, Termine.Characters.Inventory
    belongs_to :resource, Termine.Items.Resource

  end

  @doc false
  def changeset(inventory_item, attrs) do
    inventory_item
    |> cast(attrs, [])
    |> validate_required([])
  end
end
