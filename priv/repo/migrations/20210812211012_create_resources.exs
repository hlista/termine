defmodule Termine.Repo.Migrations.CreateResources do
  use Ecto.Migration

  def change do
    create table(:resources) do
      add :name, :string

    end

    create unique_index(:resources, [:name])
  end
end
