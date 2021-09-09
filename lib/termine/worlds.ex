defmodule Termine.Worlds do
	alias Termine.Repo
	alias Termine.Worlds.{Node, State, Neighbor}
	alias EctoShorts.Actions

	def create_node(params) do
		Actions.create(Node, params)
	end

	def create_state(params) do
		Actions.create(State, params)
	end
end