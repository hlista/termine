defmodule Termine.Repo.Migrations.CreateStates do
  use Ecto.Migration

  def change do
    create_query = "CREATE TYPE state_type AS ENUM ('mineable', 'blocking', 'attackable', 'donatable')"
    drop_query = "DROP TYPE state_type"
    execute(create_query, drop_query)

    create table(:states) do
      add :history_text, :text
      add :inspect_text, :text
      add :type, :state_type
      add :resource_amount, :integer
      add :resource_id, references(:resources, on_delete: :nothing)

    end

    create index(:states, [:resource_id])
  end
end

