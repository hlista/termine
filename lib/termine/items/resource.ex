defmodule Termine.Items.Resource do
  use Ecto.Schema
  import Ecto.Changeset

  schema "resources" do
    field :name, :string

  end

  def create_changeset(params) do
    changeset(%Termine.Items.Resource{}, params)
  end

  @doc false
  def changeset(resource, attrs) do
    resource
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
