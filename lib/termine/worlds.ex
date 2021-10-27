defmodule Termine.Worlds do
	alias Termine.Repo
	alias Termine.Worlds.{Node, State, Neighbor}
	alias EctoShorts.Actions
	alias Termine.Redis

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
		next_state_id = State
		|> Repo.get(next_state_id)
		|> Repo.preload([state_type_loop_until: [:until_state], state_type_loop: [], state_type_collectable: [], state_type_block_until: [:until_state]])
		|> determine_next_state(Enum.fetch!(state_id_array, index + 2))
		update_redis(next_state_id)
		Actions.update(Node, node.id, %{current_state_id: next_state_id})
	end

	def determine_next_state(state, skip_to_state_id) do
		case state.type do
			:loop ->
				state.state_type_loop.go_to_state_id
			:loop_until ->
				if (state.state_type_loop_until.until_state.has_been_completed) do
					skip_to_state_id
				else
					state.state_type_loop_until.go_to_state_id
				end
			:block_until ->
				if (state.state_type_block_until.until_state.has_been_completed) do
					skip_to_state_id
				else
					state.id
				end
			_ ->
				state.id
		end
	end

	def update_redis(state_id) do
		state = State
		|> Repo.get(state_id)
		|> Repo.preload([:state_type_collectable])
		if (state.type === :mineable or state.type === :attackable) do
			Redis.set_node_resource_amount(state.node_id, state.state_type_collectable.resource_id, state.state_type_collectable.amount)
			Redis.push_mining_node(state.node_id)
		else
			Redis.del_node_from_mining(state.node_id)
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