defmodule Termine.Miners.Expertise do
  use Ecto.Schema
  import Ecto.Changeset

  schema "expertises" do
    field :level, :integer
    field :player_miner_id, :id
    field :resource_id, :id

  end

  @doc false
  def changeset(expertise, attrs) do
    expertise
    |> cast(attrs, [:level])
    |> validate_required([:level])
  end
end
