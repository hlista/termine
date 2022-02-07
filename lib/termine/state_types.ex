defmodule Termine.StateTypes do
  alias Termine.Repo
  alias Termine.StateTypes.Collectable
  alias EctoShorts.Actions

  def create_collectable(params) do
    Actions.create(Collectable, params)
  end
end