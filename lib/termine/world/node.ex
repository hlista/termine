defmodule Termine.World.Node do
  use Ecto.Schema
  import Ecto.Changeset

  schema "nodes" do
    field :hash, :string
    field :title, :string
    belongs_to :current_state, Termine.World.State
    has_many :neighbors, Termine.World.Neighbor, foreign_key: :parent_node_id
    has_many :neighbor_nodes, through: [:neighbors, :child_node]

  end

  @available_fields [:title, :hash]

  @doc false
  def changeset(node, attrs) do
    node
    |> cast(attrs, @available_fields)
    |> validate_required(@available_fields)
    |> unique_constraint(:hash)
  end
end
