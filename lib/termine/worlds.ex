defmodule Termine.Worlds do
	alias Termine.Repo
	alias Termine.Worlds.{Node, State, Neighbor}
	alias EctoShorts.Actions

	@state_types [:state_type_loop_until, :state_type_loop, :state_type_collectable, :state_type_block_until]

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

	def update_state_type(id, params) do
		state = Repo.get(State, id)
		state = Repo.preload(state, @state_types)
		params = update_already_existing_state_type(state, params)
		changeset = Ecto.Changeset.change(state, params)
		Repo.update(changeset)
	end

	def create_neighbor(params) do
		Actions.create(Neighbor, params)
	end

	def complete_state(node_id) do
		node = Repo.get(Node, node_id)
		update_state(node.current_state_id, %{has_been_completed: true})
		unblock_nodes(node.current_state_id)
		increment_state(node)
	end

	def increment_state(node) do
		current_state_id = node.current_state_id
		state_id_array = node.state_id_array
		index = Enum.find_index(state_id_array, fn x -> x === current_state_id end)
		next_state_id = Enum.fetch!(state_id_array, index + 1)
		next_state = State
		|> Repo.get(next_state_id)
		|> Repo.preload([state_type_loop_until: [:until_state], :state_type_loop, :state_type_collectable, state_type_block_until: [:until_state]])
		case next_state.type do
			:loop ->
				Actions.update(Node, node_id, %{current_state_id: next_state.state_type_loop.go_to_state_id})
			:loop_until ->
				until_state = next_state.state_type_loop_until.until_state
				if (until_state.has_been_completed) do
					next_state_id = Enum.fetch!(state_id_array, index + 2)
					Actions.update(Node, node_id, %{current_state_id: next_state_id})
				else
					Actions.update(Node, node_id, %{current_state_id: next_state.state_type_loop_until.go_to_state_id})
				end
			:block_until ->
				until_state = next_state.state_type_block_until.until_state
				if (until_state.has_been_completed) do
					next_state_id = Enum.fetch!(state_id_array, index + 2)
					Actions.update(Node, node_id, %{current_state_id: next_state_id})
				else
					Actions.update(Node, node_id, %{current_state_id: next_state_id})
				end
			_ ->
				Actions.update(Node, node_id, %{current_state_id: next_state_id})
		end
	end

	def unblock_nodes(state_id) do
		Enum.each(Actions.all(Termine.StateTypes.BlockUntil, %{until_state_id: state_id}), fn block_until_state -> 
			Enum.each(Actions.all(Node, %{current_state_id: block_until_state.state_id}), fn blocking_node -> 
				complete_state(blocking_node.id)
			end)
		end)
	end

	defp update_already_existing_state_type(state, params) do
		Enum.reduce(params, params, fn {state_type, value}, acc ->
			type = get_in(state, [Access.key(state_type)])
			if type do
				Repo.update(Ecto.Changeset.change(type, value))
				Map.delete(acc, state_type)
			else
				acc
			end
		end)
	end
end