defmodule Termine.Repo.Migrations.CreateStateTypeCollectables do
  use Ecto.Migration

  def change do
    create table(:state_type_collectables) do
      add :amount, :integer
      add :state_id, references(:states, on_delete: :nothing)
      add :resource_id, references(:resources, on_delete: :nothing)

    end

    create index(:state_type_collectables, [:state_id])
    create index(:state_type_collectables, [:resource_id])
  end
end
