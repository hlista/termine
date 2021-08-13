defmodule Termine.Repo.Migrations.CreateInventories do
  use Ecto.Migration

  def change do
    create table(:inventories) do
      add :player_id, references(:players, on_delete: :nothing)

    end

    create index(:inventories, [:player_id])
  end
end
