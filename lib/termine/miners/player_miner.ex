defmodule Termine.Miners.PlayerMiner do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "player_miners" do
    belongs_to :miner, Termine.Miners.Miner
    belongs_to :player, Termine.Characters.Player
    belongs_to :location, Termine.Worlds.Node

    has_one :inventory, through: [:player, :inventory]

    field :last_time_mined, :utc_datetime
    field :pending, :boolean
  end

  def create_changeset(params) do
    changeset(%Termine.Miners.PlayerMiner{}, params)
  end

  @doc false
  def changeset(player_miner, attrs) do
    player_miner
    |> cast(attrs, [:miner_id, :player_id, :location_id, :last_time_mined, :pending])
    |> validate_required([:miner_id, :player_id])
  end

  def player_miners_with_location_query(query \\ Termine.Miners.PlayerMiner) do
    query
    |> where([p], not is_nil(p.location_id))
  end

  def get_player_miners_lock_query(query \\ Termine.Miners.PlayerMiner, limit) do
    query
    |> where([pm], not is_nil(pm.location_id) and pm.last_time_mined < ago(5, "second") and pm.pending == true)
    |> lock("FOR UPDATE SKIP LOCKED")
    |> limit(^limit)
  end

  def player_miners_query(query \\ Termine.Miners.PlayerMiner, player_miner_ids) do
    query
    |> where([pm], pm.id in ^player_miner_ids)
  end 
end
