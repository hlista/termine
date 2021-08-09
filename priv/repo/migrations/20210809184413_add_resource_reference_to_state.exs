defmodule Termine.Repo.Migrations.AddResourceReferenceToState do
  use Ecto.Migration

  def change do
    alter table("states") do
      add :resource_id, references(:resources, on_delete: :nothing)
    end
  end
end
