defmodule Termine.Repo.Migrations.CreateInventoryItems do
  use Ecto.Migration

  def change do
    create table(:inventory_items) do
      add :amount, :integer
      add :player_id, references(:players, on_delete: :nothing)
      add :resource_id, references(:resources, on_delete: :nothing)

    end

    create index(:inventory_items, [:player_id])
    create index(:inventory_items, [:resource_id])
  end
end
