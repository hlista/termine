defmodule Termine.Worlds.Node do
  use Ecto.Schema
  import Ecto.Changeset

  schema "nodes" do
    field :hash, :string
    field :name, :string
    field :intro_text, :string
    has_many :neighbors, Termine.Worlds.Neighbor, foreign_key: :parent_node_id
    has_many :neighbor_nodes, through: [:neighbors, :child_node]
    has_many :players, Termine.Characters.Player, foreign_key: :location_id
    has_many :player_miners, Termine.Miners.PlayerMiner, foreign_key: :location_id

    belongs_to :current_state, Termine.Worlds.State
    has_many :states, Termine.Worlds.State
    field :state_id_array, {:array, :id}

  end

  def create_changeset(params) do
    changeset(%Termine.Worlds.Node{}, params)
  end

  @doc false
  def changeset(node, attrs) do
    node
    |> cast(attrs, [:name, :hash, :intro_text, :current_state_id, :state_id_array])
    |> validate_required([:name, :hash, :intro_text])
    |> unique_constraint(:name)
    |> unique_constraint(:hash)
  end
end
