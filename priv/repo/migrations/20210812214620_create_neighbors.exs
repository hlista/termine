defmodule Termine.Repo.Migrations.CreateNeighbors do
  use Ecto.Migration

  def change do
    create table(:neighbors) do
      add :parent_node_id, references(:nodes, on_delete: :nothing)
      add :child_node_id, references(:nodes, on_delete: :nothing)

    end

    create index(:neighbors, [:parent_node_id])
    create index(:neighbors, [:child_node_id])
    create unique_index(:neighbors, [:parent_node_id, :child_node_id])
    create unique_index(:neighbors, [:child_node_id, :parent_node_id])
  end
end
