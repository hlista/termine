defmodule Termine.Worlds.State do
  use Ecto.Schema
  import Ecto.Changeset

  schema "states" do
    field :history_text, :string
    field :inspect_text, :string
    field :resource_amount, :integer
    field :type, Ecto.Enum, values: [:mineable, :blocking, :attackable, :donatable]
    belongs_to :resource, Termine.Items.Resource
    belongs_to :next_state, Termine.Worlds.State

  end

  def create_changeset(params) do
    changeset(%Termine.Worlds.State{}, params)
  end

  @doc false
  def changeset(state, attrs) do
    state
    |> cast(attrs, [:history_text, :inspect_text, :resource_amount, :type, :next_state_id, :resource_id])
    |> validate_required([:history_text, :inspect_text, :resource_amount, :type])
  end
end
