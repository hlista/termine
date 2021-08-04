defmodule Termine.World.Node do
  use Ecto.Schema
  import Ecto.Changeset

  schema "nodes" do
    field :hash, :string
    field :title, :string
    belongs_to :current_state, Termine.World.State

    timestamps()
  end

  @doc false
  def changeset(node, attrs) do
    node
    |> cast(attrs, [:title, :hash])
    |> validate_required([:title, :hash])
    |> unique_constraint(:hash)
  end
end
