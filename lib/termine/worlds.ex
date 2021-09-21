defmodule Termine.Worlds do
	alias Termine.Repo
	alias Termine.Worlds.{Node, State, Neighbor}
	alias EctoShorts.Actions

	def list_nodes(params) do
		{:ok, Actions.all(Node, params)}
	end

	def list_states(params) do
		{:ok, Actions.all(State, params)}
	end

	def create_node(params) do
		Actions.create(Node, params)
	end

	def update_node(id, params) do
		Actions.update(Node, id, params)
	end

	def create_state(params) do
		Actions.create(State, params)
	end

	def update_state(id, params) do
		Actions.update(State, id, params)
	end

	def create_neighbor(params) do
		Actions.create(Neighbor, params)
	end
end