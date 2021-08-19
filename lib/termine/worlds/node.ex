defmodule Termine.Worlds.Node do
  use Ecto.Schema
  import Ecto.Changeset

  schema "nodes" do
    field :hash, :string
    field :name, :string
    has_one :current_state, Termine.Worlds.State
    has_many :neighbors, Termine.Worlds.Neighbor, foreign_key: :parent_node_id
    has_many :neighbor_nodes, through: [:neighbors, :child_node]
    has_many :players, Termine.Characters.Player, foreign_key: :location_id
    has_many :miners, Termine.Characters.Miner, foreign_key: :location_id

  end

  @doc false
  def changeset(node, attrs) do
    node
    |> cast(attrs, [:name, :hash])
    |> validate_required([:name, :hash])
    |> unique_constraint(:name)
    |> unique_constraint(:hash)
  end
end
