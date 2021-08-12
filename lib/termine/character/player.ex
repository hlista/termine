defmodule Termine.Character.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "players" do
    belongs_to :user, Termine.Account.User
    has_many :inventory_items, Termine.Character.InventoryItem
    has_many :miners, Termine.Character.Miner

  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [])
    |> validate_required([])
  end
end
