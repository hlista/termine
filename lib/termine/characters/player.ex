defmodule Termine.Characters.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "players" do
    belongs_to :user, Termine.Accounts.User
    belongs_to :location, Termine.Worlds.Node
    has_one :inventory, Termine.Characters.Inventory
    has_many :player_miners, Termine.Miners.PlayerMiner
    many_to_many :miners, Termine.Miners.Miner, join_through: Termine.Miners.PlayerMiner
    field :username, :string
    
  end

  def create_changeset(params) do
    changeset(%Termine.Characters.Player{}, params)
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:username, :location_id, :user_id])
    |> validate_required([:username])
  end
end
