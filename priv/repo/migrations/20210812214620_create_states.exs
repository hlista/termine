defmodule Termine.Repo.Migrations.CreateStates do
  use Ecto.Migration

  def change do
    create_query = "CREATE TYPE state_type AS ENUM ('mineable', 'blocking', 'attackable', 'donatable')"
    drop_query = "DROP TYPE state_type"
    execute(create_query, drop_query)

    create table(:states) do
      add :history_text, :string
      add :inspect_text, :string
      add :intro_text, :string
      add :type, :state_type
      add :resource_amount, :integer
      add :resource_id, references(:resources, on_delete: :nothing)
      add :next_state_id, references(:states, on_delete: :nothing)
      add :node_id, references(:nodes, on_delete: :nothing)

    end

    create index(:states, [:resource_id])
    create index(:states, [:next_state_id])
    create index(:states, [:node_id])
  end
end
