defmodule Termine.Repo.Migrations.CreateMiners do
  use Ecto.Migration

  def change do
    create table(:miners) do
      add :name, :string
      add :combat_level, :integer
      add :gather_level, :integer
      add :player_id, references(:players, on_delete: :nothing)

    end

    create index(:miners, [:player_id])
  end
end
