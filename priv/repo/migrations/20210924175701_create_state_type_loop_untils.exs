defmodule Termine.Repo.Migrations.CreateStateTypeLoopUntils do
  use Ecto.Migration

  def change do
    create table(:state_type_loop_untils) do
      add :state_id, references(:states, on_delete: :nothing)
      add :go_to_state_id, references(:states, on_delete: :nothing)
      add :until_state_id, references(:states, on_delete: :nothing)

    end

    create index(:state_type_loop_untils, [:state_id])
    create index(:state_type_loop_untils, [:go_to_state_id])
    create index(:state_type_loop_untils, [:until_state_id])
  end
end
