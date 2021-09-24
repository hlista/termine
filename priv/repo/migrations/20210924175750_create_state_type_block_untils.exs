defmodule Termine.Repo.Migrations.CreateStateTypeBlockUntils do
  use Ecto.Migration

  def change do
    create table(:state_type_block_untils) do
      add :state_id, references(:states, on_delete: :nothing)
      add :until_state_id, references(:states, on_delete: :nothing)

    end

    create index(:state_type_block_untils, [:state_id])
    create index(:state_type_block_untils, [:until_state_id])
  end
end
