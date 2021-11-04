defmodule Termine.Items do
  alias Termine.Repo
  alias Termine.Items.Resource
  alias EctoShorts.Actions

  def create_resource(params) do
    Actions.create(Resource, params)
  end
end