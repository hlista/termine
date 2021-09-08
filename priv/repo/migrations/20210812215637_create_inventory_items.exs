defmodule Termine.Repo.Migrations.CreateInventoryItems do
  use Ecto.Migration

  def change do
    create table(:inventory_items) do
      add :inventory_id, references(:inventories, on_delete: :nothing)
      add :resource_id, references(:resources, on_delete: :nothing)
      add :amount, :integer

    end

    create index(:inventory_items, [:inventory_id])
    create index(:inventory_items, [:resource_id])
  end
end
