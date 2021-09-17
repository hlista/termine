defmodule Termine.Characters.PlayerNodeHistory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "player_node_histories" do
    belongs_to :node, Termine.Worlds.Node
    belongs_to :player, Termine.Characters.Player

  end

  def create_changeset(params) do
    changeset(%Termine.Characters.PlayerNodeHistory{}, params)
  end

  @doc false
  def changeset(node_history, attrs) do
    node_history
    |> cast(attrs, [:node_id, :player_id])
    |> validate_required([])
    |> unique_constraint([:node_id, :player_id])
  end
end
