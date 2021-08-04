defmodule Termine.Repo.Migrations.CreateNeighbors do
  use Ecto.Migration

  def change do
    create table(:neighbors) do
      add :left_node, references(:nodes, on_delete: :nothing)
      add :right_node, references(:nodes, on_delete: :nothing)

      timestamps()
    end

    create index(:neighbors, [:left_node])
    create index(:neighbors, [:right_node])
  end
end
