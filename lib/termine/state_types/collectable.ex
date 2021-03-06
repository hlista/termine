defmodule Termine.StateTypes.Collectable do
  use Ecto.Schema
  import Ecto.Changeset

  schema "state_type_collectables" do
    field :amount, :integer
    belongs_to :state, Termine.Worlds.State
    belongs_to :resource, Termine.Worlds.State

  end

  def create_changeset(params) do
    changeset(%Termine.StateTypes.Collectable{}, params)
  end

  @doc false
  def changeset(collectable, attrs) do
    collectable
    |> cast(attrs, [:amount, :resource_id])
    |> validate_required([:amount, :resource_id])
  end
end
