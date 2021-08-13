defmodule Termine.Characters.Miner do
  use Ecto.Schema
  import Ecto.Changeset

  schema "miners" do
    field :combat_level, :integer
    field :gather_level, :integer
    field :name, :string
    belongs_to :player, Termine.Characters.Player

  end

  @doc false
  def changeset(miner, attrs) do
    miner
    |> cast(attrs, [:name, :combat_level, :gather_level])
    |> validate_required([:name, :combat_level, :gather_level])
  end
end
