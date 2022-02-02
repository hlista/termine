defmodule Termine.StateHandler do
  alias Termine.Worlds
  alias Termine.StateTypes

  def complete_state(node) do
    Worlds.update_state(node.current_state_id, %{has_been_completed: true})
  end

  def increment_state(node) do
    current_state_id = node.current_state_id
    state_id_array = node.state_id_array
    index = Enum.find_index(state_id_array, fn x -> x === current_state_id end)
    next_state_id = Enum.fetch!(state_id_array, index + 1)

    {:ok, next_state} = Worlds.find_state(%{id: next_state_id, preload: [state_type_loop_until: [:until_state], state_type_loop: [], state_type_collectable: [], state_type_block_until: [:until_state]]})
    next_state_id = determine_next_state(next_state, state_id_array, index + 2)

    Worlds.update_node(node.id, %{current_state_id: next_state_id})
  end

  def determine_next_state(state, state_id_array, skip_to_index) do
    case state.type do
      :loop ->
        state.state_type_loop.go_to_state_id
      :loop_until ->
        if (state.state_type_loop_until.until_state.has_been_completed) do
          Enum.fetch!(state_id_array, skip_to_index)
        else
          state.state_type_loop_until.go_to_state_id
        end
      :block_until ->
        if (state.state_type_block_until.until_state.has_been_completed) do
          Enum.fetch!(state_id_array, skip_to_index)
        else
          state.id
        end
      _ ->
        state.id
    end
  end

  def unblock_nodes(state_id) do
    {:ok, block_until_state_types} = StateTypes.list_block_until(%{until_state_id: state_id})
    state_ids = Enum.map(block_until_state_types, fn x -> x.state_id end)
    {:ok, blocked_nodes} = Worlds.list_nodes_on_states(state_ids)
    Enum.each(blocked_nodes, fn blocking_node ->
      GenServer.cast(Termine.Distributor, {:increment_state, Integer.to_string(blocking_node.id)})
    end)
  end

  def set_node_to_mining(node_id) do
    {:ok, node} = Worlds.find_node(%{preload: [current_state: [state_type_collectable: []]]})
    if node.current_state.type === :mineable do
      Termine.NodeResourceCache.set_node_to_mining(node.id, node.current_state.state_type_collectable.amount, node.current_state.state_type_collectable.resource_id)
    end
    if node.current_state.type === :attackable do
      Termine.NodeResourceCache.set_node_to_mining(node.id, node.current_state.state_type_collectable.amount, 0)
    end
  end

  def is_node_mining(node_id) do
    {:ok, node} = Worlds.find_node(%{id: node_id, preload: [:current_state]})
    (node.current_state.type === :mineable or node.current_state.type === :attackable)
  end
end