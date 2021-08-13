defmodule Termine.Characters.InventoryItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "inventory_items" do
    belongs_to :inventory_id, Termine.Characters.Inventory
    belongs_to :resource_id, Termine.Items.Resource

    timestamps()
  end

  @doc false
  def changeset(inventory_item, attrs) do
    inventory_item
    |> cast(attrs, [])
    |> validate_required([])
  end
end
