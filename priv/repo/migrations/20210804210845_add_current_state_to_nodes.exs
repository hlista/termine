defmodule Termine.Repo.Migrations.AddCurrentStateToNodes do
  use Ecto.Migration

  def change do
    alter table("nodes") do
      add :current_state_id, references(:states, on_delete: :nothing)
    end
  end
end
