defmodule TermineWeb.Schema.Mutations.StateTest do
  use Termine.DataCase, async: true

  @create_state_doc """
  mutation CreateState($name: String!, $description: String!) {
    createState(name: $name, description: $description) {
      id
      name
      description
    }
  }
  """
end