defmodule Termine.Repo.Migrations.CreateStates do
  use Ecto.Migration

  def change do
    create table(:states) do
      add :inspect_text, :text
      add :history_text, :text
      add :type, :string
      add :resource_amount, :integer
      add :next_state_id, references(:states, on_delete: :nothing)

    end

    create index(:states, [:next_state_id])
  end
end
