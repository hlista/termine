defmodule Termine.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :username, :string
    has_one :player, Termine.Character.Player

  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username, :password_hash])
    |> validate_required([:email, :username, :password_hash])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end
end
