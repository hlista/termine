defmodule TermineWeb.Resolvers.Neighbor do
	alias Termine.Worlds

	def create(_, %{node_one_id: node_one_id, node_two_id: node_two_id}, _) do
		node_one_id = String.to_integer(node_one_id)
		node_two_id = String.to_integer(node_two_id)
		Worlds.create_neighbor(%{parent_node_id: node_one_id, child_node_id: node_two_id})
		{:ok, neighbor} = Worlds.create_neighbor(%{parent_node_id: node_two_id, child_node_id: node_one_id})
		%{parent_node: node1, child_node: node2} = neighbor
		|> Termine.Repo.preload(:parent_node) #temporarily here until dataloader integration
		|> Termine.Repo.preload(:child_node)
		{:ok, [node1, node2]}
	end
end