defmodule Termine.Repo.Migrations.CreateChecks do
  use Ecto.Migration

  def change do
    create table(:checks) do
      add :title, :string

    end

  end
end
