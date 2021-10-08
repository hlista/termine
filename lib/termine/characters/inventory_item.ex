defmodule Termine.Characters.InventoryItem do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  schema "inventory_items" do
    belongs_to :inventory, Termine.Characters.Inventory
    belongs_to :resource, Termine.Items.Resource
    field :amount, :integer

  end

  def create_changeset(params) do
    changeset(%Termine.Characters.InventoryItem{}, params)
  end

  @doc false
  def changeset(inventory_item, attrs) do
    inventory_item
    |> cast(attrs, [:amount, :inventory_id, :resource_id])
    |> validate_required([])
    |> unique_constraint([:inventory_id, :resource_id])
  end

  def query_increment_amount(query \\ Termine.Characters.InventoryItem, inventory_item_id, incr_by) do
    query
    |> update([inc: [amount: ^incr_by]])
    |> where([i], i.id == ^inventory_item_id)
    |> select([i], i)
  end
end
