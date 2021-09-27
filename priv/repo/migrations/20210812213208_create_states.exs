defmodule Termine.Repo.Migrations.CreateStates do
  use Ecto.Migration

  def change do
    create_query = "CREATE TYPE state_type AS ENUM ('mineable', 'attackable', 'donatable', 'block', 'block_until', 'loop', 'loop_until')"
    drop_query = "DROP TYPE state_type"
    execute(create_query, drop_query)

    create table(:states) do
      add :inspect_text, :text
      add :type, :state_type

    end
  end
end

