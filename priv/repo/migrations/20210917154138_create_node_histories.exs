defmodule Termine.Repo.Migrations.CreateNodeHistories do
  use Ecto.Migration

  def change do
    create table(:node_histories) do
      add :node_id, references(:nodes, on_delete: :nothing)
      add :player_id, references(:players, on_delete: :nothing)

    end

    create index(:node_histories, [:node_id])
    create index(:node_histories, [:player_id])
    create unique_index(:node_histories, [:node_id, :player_id])
  end
end
