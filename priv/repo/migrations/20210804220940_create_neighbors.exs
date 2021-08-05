defmodule Termine.Repo.Migrations.CreateNeighbors do
  use Ecto.Migration

  def change do
    create table(:neighbors) do
      add :parent_node_id, references(:nodes, on_delete: :nothing)
      add :child_node_id, references(:nodes, on_delete: :nothing)

    end

    create unique_index(:neighbors, [:parent_node_id, :child_node_id])
  end
end
