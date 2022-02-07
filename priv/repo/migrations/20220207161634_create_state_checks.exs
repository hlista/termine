defmodule Termine.Repo.Migrations.CreateStateChecks do
  use Ecto.Migration

  def change do
    create table(:state_checks) do
      add :check_id, references(:checks, on_delete: :nothing)
      add :state_id, references(:states, on_delete: :nothing)

    end

    create index(:state_checks, [:check_id])
    create index(:state_checks, [:state_id])
  end
end
