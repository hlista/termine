defmodule Termine.Repo.Migrations.CreateUsersAuthTables do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""
    create_query = "CREATE TYPE user_role AS ENUM ('admin', 'user')"
    drop_query = "DROP TYPE user_role"
    execute(create_query, drop_query)

    create table(:users) do
      add :email, :citext, null: false
      add :hashed_password, :string, null: false
      add :role, :user_role
      add :confirmed_at, :naive_datetime
      timestamps()
    end

    create unique_index(:users, [:email])

    create table(:users_tokens) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :token, :binary, null: false
      add :context, :string, null: false
      add :sent_to, :string
      timestamps(updated_at: false)
    end

    create index(:users_tokens, [:user_id])
    create unique_index(:users_tokens, [:context, :token])
  end
end
