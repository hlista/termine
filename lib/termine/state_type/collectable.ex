defmodule Termine.StateType.Collectable do
  use Ecto.Schema
  import Ecto.Changeset

  schema "state_type_collectables" do
    field :amount, :integer
    belongs_to :state, Termine.Worlds.State
    belongs_to :resource, Termine.Worlds.State

  end

  @doc false
  def changeset(collectable, attrs) do
    collectable
    |> cast(attrs, [:amount])
    |> validate_required([:amount])
  end
end
