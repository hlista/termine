defmodule Termine.NodeResourceCache do
  use GenServer

  @default_name __MODULE__

  def start_link(opts) do
    table = :ets.new(@default_name, opts)
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

end