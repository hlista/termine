defmodule Termine.Repo.Migrations.CreateNodes do
  use Ecto.Migration

  def change do
    create table(:nodes) do
      add :name, :string
      add :hash, :string

    end

    create unique_index(:nodes, [:name])
    create unique_index(:nodes, [:hash])
  end
end
