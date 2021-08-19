defmodule Termine.Worlds.State do
  use Ecto.Schema
  import Ecto.Changeset

  schema "states" do
    field :history_text, :string
    field :inspect_text, :string
    field :intro_text, :string
    field :type, :string
    field :resource_amount, :integer
    belongs_to :resource, Termine.Items.Resource
    belongs_to :next_state, Termine.Worlds.State
    belongs_to :node, Termine.Worlds.Node

  end

  @doc false
  def changeset(state, attrs) do
    state
    |> cast(attrs, [:history_text, :inspect_text, :intro_text, :type])
    |> validate_required([:history_text, :inspect_text, :intro_text, :type])
  end
end
