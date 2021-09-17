defmodule Termine.Worlds.Neighbor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "neighbors" do
    belongs_to :parent_node, Termine.Worlds.Node
    belongs_to :child_node, Termine.Worlds.Node

  end

  def create_changeset(params) do
    changeset(%Termine.Worlds.Neighbor{}, params)
  end

  @doc false
  def changeset(neighbor, attrs) do
    neighbor
    |> cast(attrs, [:parent_node_id, :child_node_id])
    |> validate_required([])
    |> unique_constraint([:parent_node_id, :child_node_id])
    |> unique_constraint([:child_node_id, :parent_node_id])
  end
end
