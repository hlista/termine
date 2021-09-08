defmodule Termine.Characters.InventoryItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "inventory_items" do
    belongs_to :inventory, Termine.Characters.Inventory
    belongs_to :resource, Termine.Items.Resource
    field :amount, :integer

  end

  @doc false
  def changeset(inventory_item, attrs) do
    inventory_item
    |> cast(attrs, [:amount])
    |> validate_required([])
  end
end
