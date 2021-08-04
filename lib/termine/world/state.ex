defmodule Termine.World.State do
  use Ecto.Schema
  import Ecto.Changeset

  schema "states" do
    field :history_text, :string
    field :inspect_text, :string
    field :resource_amount, :integer
    field :type, :string
    field :next_state, :id

    timestamps()
  end

  @doc false
  def changeset(state, attrs) do
    state
    |> cast(attrs, [:inspect_text, :history_text, :type, :resource_amount])
    |> validate_required([:inspect_text, :history_text, :type, :resource_amount])
  end
end
