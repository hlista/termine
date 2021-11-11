defmodule TermineWeb.Schema.Mutations.NeighborTest do
  use Termine.DataCase, async: true

  @create_neighbor_doc """
  mutation CreateNeighbor($node_one_id: ID!, $node_two_id: ID!) {
    createNeighbor(node_one_id: $node_one_id, node_two_id: $node_two_id) {
      childNode{
        id
        hash
        name
      }
      parentNode {
        id
        hash
        name
      }
    }
  }
  """
end