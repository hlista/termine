defmodule TermineWeb.Schema.Mutations.ResourceTest do
  use Termine.DataCase, async: true

  @create_resource_doc """
  mutation CreateResource($name: String!) {
    createResource(name: $name) {
      id
      name
    }
  }
  """
end