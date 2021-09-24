defmodule Termine.Repo.Migrations.CreateStateTypeLoops do
  use Ecto.Migration

  def change do
    create table(:state_type_loops) do
      add :state_id, references(:states, on_delete: :nothing)
      add :go_to_state_id, references(:states, on_delete: :nothing)

    end

    create index(:state_type_loops, [:state_id])
    create index(:state_type_loops, [:go_to_state_id])
  end
end
