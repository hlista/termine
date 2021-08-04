defmodule Termine.Repo.Migrations.CreateNodes do
  use Ecto.Migration

  def change do
    create table(:nodes) do
      add :title, :string
      add :hash, :string

      timestamps()
    end

    create unique_index(:nodes, [:hash])
  end
end
