defmodule Termine.Character.Miner do
  use Ecto.Schema
  import Ecto.Changeset

  schema "miners" do
    field :combat_level, :integer
    field :gather_level, :integer
    belongs_to :player, Termine.Character.Player

  end

  @doc false
  def changeset(miner, attrs) do
    miner
    |> cast(attrs, [:combat_level, :gather_level])
    |> validate_required([:combat_level, :gather_level])
  end
end
