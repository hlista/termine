defmodule Termine.Repo.Migrations.CreatePlayerMiners do
  use Ecto.Migration

  def change do
    create table(:player_miners) do
      add :miner_id, references(:miners, on_delete: :nothing)
      add :player_id, references(:players, on_delete: :nothing)
      add :location_id, references(:nodes, on_delete: :nothing)

    end

    create index(:player_miners, [:miner_id])
    create index(:player_miners, [:player_id])
    create index(:player_miners, [:location_id])
  end
end
