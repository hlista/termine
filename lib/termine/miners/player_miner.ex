defmodule Termine.Miners.PlayerMiner do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "player_miners" do
    belongs_to :miner, Termine.Miners.Miner
    belongs_to :player, Termine.Characters.Player
    belongs_to :location, Termine.Worlds.Node
    has_many :expertises, Termine.Miners.Expertise
    has_one :inventory, through: [:player, :inventory]

  end

  def create_changeset(params) do
    changeset(%Termine.Miners.PlayerMiner{}, params)
  end

  @doc false
  def changeset(player_miner, attrs) do
    player_miner
    |> cast(attrs, [:miner_id, :player_id, :location_id])
    |> validate_required([:miner_id, :player_id])
  end

  def player_miners_with_location_query(query \\ Termine.Miners.PlayerMiner) do
    query
    |> where([p], not is_nil(p.location_id))
  end
end
