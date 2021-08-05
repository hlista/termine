defmodule Termine.World.State do
  use Ecto.Schema
  import Ecto.Changeset

  schema "states" do
    field :history_text, :string
    field :inspect_text, :string
    field :resource_amount, :integer
    field :type, :string
    belongs_to :next_state, Termine.World.State

  end

  @available_fields [:inspect_text, :history_text, :type, :resource_amount]

  @doc false
  def changeset(state, attrs) do
    state
    |> cast(attrs, @available_fields)
    |> validate_required(@available_fields)
  end
end
