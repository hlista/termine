defmodule Termine.Worlds.Neighbor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "neighbors" do
    belongs_to :parent_node, Termine.Worlds.Node
    belongs_to :child_node, Termine.Worlds.Node

  end

  @doc false
  def changeset(neighbor, attrs) do
    neighbor
    |> cast(attrs, [])
    |> validate_required([])
  end
end
