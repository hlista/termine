defmodule Termine.Miners.Miner do
  use Ecto.Schema
  import Ecto.Changeset

  schema "miners" do
    field :name, :string
    field :description, :string

  end

  @doc false
  def changeset(miner, attrs) do
    miner
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end