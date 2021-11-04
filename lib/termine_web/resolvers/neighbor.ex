defmodule TermineWeb.Resolvers.Neighbor do
  alias Termine.Worlds

  def create(%{node_one_id: node_one_id, node_two_id: node_two_id}, _) do
    node_one_id = String.to_integer(node_one_id)
    node_two_id = String.to_integer(node_two_id)
    Worlds.create_neighbor(%{parent_node_id: node_one_id, child_node_id: node_two_id})
    Worlds.create_neighbor(%{parent_node_id: node_two_id, child_node_id: node_one_id})
  end
end