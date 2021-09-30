defmodule Termine.Miners.PlayerMiner do
  use Ecto.Schema
  import Ecto.Changeset

  schema "player_miners" do
    field :miner_id, :id
    field :player_id, :id
    field :location_id, :id

  end

  @doc false
  def changeset(player_miner, attrs) do
    player_miner
    |> cast(attrs, [])
    |> validate_required([])
  end
end
