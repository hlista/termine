defmodule Termine.World.Neighbor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "neighbors" do
    belongs_to :left_node, Termine.World.Node
    belongs_to :right_node, Termine.World.Node

    timestamps()
  end

  @doc false
  def changeset(neighbor, attrs) do
    neighbor
    |> cast(attrs, [])
    |> validate_required([])
  end
end
