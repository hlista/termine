defmodule Termine.Repo.Migrations.CreateMiners do
  use Ecto.Migration

  def change do
    create table(:miners) do
      add :name, :string
      add :description, :string

    end

  end
end
