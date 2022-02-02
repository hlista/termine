defmodule Termine.NodeResourceCache do
  use GenServer
  alias Termine.Worlds

  @default_name __MODULE__

  def start_link(opts) do
    table = :ets.new(@default_name, opts)
    populate_cache()
    GenServer.start_link(@default_name, %{table: table}, name: @default_name)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  def set_node_to_mining(name \\ @default_name, node_id, resource_amount, resource_id) do
    :ets.insert(name, {node_id, resource_amount, resource_id})
  end

  def update_resource_amount(name \\ @default_name, node_id, amount) do
    :ets.update_counter(name, node_id, {2, amount, 0, 0})
  end

  def get_resource_id(name \\ @default_name, node_id) do
    :ets.lookup_element(name, node_id, 3)
  end

  defp populate_cache(name \\ @default_name) do
    {:ok, nodes} = Worlds.list_nodes(%{preload: [current_state: [state_type_collectable: []]]})
    Enum.each(nodes, fn node -> 
      if node.current_state.type === :mineable do
        set_node_to_mining(node.id, node.current_state.state_type_collectable.amount, node.current_state.state_type_collectable.resource_id)
      end
      if node.current_state.type === :attackable do
        set_node_to_mining(node.id, node.current_state.state_type_collectable.amount, 0)
      end
    end)
  end

end