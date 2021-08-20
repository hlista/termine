defmodule Termine.Characters.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "players" do
    belongs_to :user, Termine.Accounts.User
    belongs_to :location, Termine.Worlds.Node
    has_one :inventory, Termine.Characters.Inventory
    field :username, :string
    
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [])
    |> validate_required([])
  end
end
