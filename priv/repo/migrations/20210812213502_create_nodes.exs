defmodule Termine.Repo.Migrations.CreateNodes do
  use Ecto.Migration

  def change do
    create table(:nodes) do
      add :name, :string
      add :hash, :string
      add :intro_text, :text
      add :state_id,  references(:states, on_delete: :nothing) 
    end

    create unique_index(:nodes, [:name])
    create unique_index(:nodes, [:hash])
    create index(:nodes, [:state_id])
  end
end