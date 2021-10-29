defmodule Termine.StateHandler do
	alias Termine.Worlds

	def complete_state(node_id) do
		{:ok, node} = Worlds.find_node(%{id: node_id})
		Worlds.update_state(node.current_state_id, %{has_been_completed: true})
		unblock_nodes(node.current_state_id)
		increment_state(node)
	end

	def increment_state(node) do
		current_state_id = node.current_state_id
		state_id_array = node.state_id_array
		index = Enum.find_index(state_id_array, fn x -> x === current_state_id end)
		next_state_id = Enum.fetch!(state_id_array, index + 1)

		{:ok, next_state} = Worlds.find_state(%{id: next_state_id, preload: [state_type_loop_until: [:until_state], state_type_loop: [], state_type_collectable: [], state_type_block_until: [:until_state]]})
		next_state_id = determine_next_state(next_state, Enum.fetch!(state_id_array, index + 2))

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

	def unblock_nodes(state_id) do
		{:ok, block_until_states} = Worlds.list_states(%{until_state_id: state_id})
		Enum.each(block_until_states, fn block_until_state ->
			{:ok, blocking_nodes} = Worlds.list_nodes(%{current_state_id: block_until_state.state_id})
			Enum.each(blocking_nodes, fn blocking_node ->
				GenServer.cast(Termine.Distributor, {:increment_state, blocking_node.id})
			end)
		end)
	end

	def update_redis(state_id) do
		{:ok, state} = Worlds.find_state(%{id: state_id, preload: [:state_type_collectable]})
		if (state.type === :mineable or state.type === :attackable) do
			Redis.set_node_resource_amount(state.node_id, state.state_type_collectable.resource_id, state.state_type_collectable.amount)
			Redis.push_mining_node(state.node_id)
		else
			Redis.del_node_from_mining(state.node_id)
		end
	end

	def is_node_mining(node_id) do
		node = Worlds.find_node(%{id: node_id, preload: [:current_state]})
		(node.current_state.type === :mineable or node.current_state.type === :attackable)
	end
end