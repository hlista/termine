defmodule Termine.Repo.Migrations.CreatePlayerNodeHistories do
  use Ecto.Migration

  def change do
    create table(:player_node_histories) do
      add :node_id, references(:nodes, on_delete: :nothing)
      add :player_id, references(:players, on_delete: :nothing)

    end

    create index(:player_node_histories, [:node_id])
    create index(:player_node_histories, [:player_id])
    create unique_index(:player_node_histories, [:node_id, :player_id])
  end
end
