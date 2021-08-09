defmodule Termine.Character.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "players" do
    belongs_to :user, Termine.Account.User

  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [])
    |> validate_required([])
  end
end
