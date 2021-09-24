defmodule Termine.Repo.Migrations.CreateNodes do
  use Ecto.Migration

  def change do
    create table(:nodes) do
      add :name, :string
      add :hash, :string
      add :intro_text, :text
      add :current_state_id,  references(:states, on_delete: :nothing) 
      add :state_id_array, {:array, :id}
    end

    alter table(:states) do
      add :node_id, references(:nodes, on_delete: :nothing)
    end

    create unique_index(:nodes, [:name])
    create unique_index(:nodes, [:hash])
    create index(:nodes, [:current_state_id])
    create index(:states, [:node_id])
  end
end