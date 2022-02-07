defmodule Termine.Checks.Check do
  use Ecto.Schema
  import Ecto.Changeset

  schema "check" do
    field :title, :string

  end

  @doc false
  def changeset(check, attrs) do
    check
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
