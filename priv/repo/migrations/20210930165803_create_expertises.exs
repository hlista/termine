defmodule Termine.Repo.Migrations.CreateExpertises do
  use Ecto.Migration

  def change do
    create table(:expertises) do
      add :level, :integer
      add :player_miner_id, references(:player_miners, on_delete: :nothing)
      add :resource_id, references(:resources, on_delete: :nothing)

    end

    create index(:expertises, [:player_miner_id])
    create index(:expertises, [:resource_id])
  end
end
