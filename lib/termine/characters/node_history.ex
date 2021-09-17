defmodule Termine.Characters.NodeHistory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "node_histories" do
    belongs_to :node, Termine.Worlds.Node
    belongs_to :player, Termine.Characters.Player

  end

  @doc false
  def changeset(node_history, attrs) do
    node_history
    |> cast(attrs, [:node_id, :player_id])
    |> validate_required([])
    |> unique_constraint([:node_id, :player_id])
  end
end
