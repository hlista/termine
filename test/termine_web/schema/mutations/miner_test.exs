defmodule TermineWeb.Schema.Mutations.MinerTest do
  use Termine.DataCase, async: true

  @create_miner_doc """
  mutation CreateMiner($name: String!, $description: String!) {
    createUser(name: $name, description: $description) {
      id
      name
      description
    }
  }
  """
end