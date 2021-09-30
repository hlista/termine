defmodule Termine.Miners.Expertise do
  use Ecto.Schema
  import Ecto.Changeset

  schema "expertises" do
    field :level, :integer
    belongs_to :player_miner, Termine.Miners.PlayerMiner
    belongs_to :resource, Termine.Items.Resource

  end

  def create_changeset(params) do
    changeset(%Termine.Miners.Expertise{}, params)
  end

  @doc false
  def changeset(expertise, attrs) do
    expertise
    |> cast(attrs, [:level, :player_miner_id, :resource_id])
    |> validate_required([:level, :player_miner_id, :resource_id])
  end
end
