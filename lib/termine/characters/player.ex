defmodule Termine.Characters.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "players" do
    belongs_to :user, Termine.Accounts.User
    belongs_to :location, Termine.Worlds.Node
    has_one :inventory, Termine.Characters.Inventory
    field :username, :string
    
  end

  @available_fields [:username]

  def create_changeset(params) do
    changeset(%Termine.Characters.Player{}, params)
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, @available_fields)
    |> validate_required(@available_fields)
  end
end
