defmodule Termine.World.Neighbor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "neighbors" do
    belongs_to :parent_node, Termine.World.Node
    belongs_to :child_node, Termine.World.Node

  end

  @doc false
  def changeset(neighbor, attrs) do
    neighbor
    |> cast(attrs, [])
    |> validate_required([])
    |> unique_constraint([:parent_node_id, :child_node_id])
  end

end
