defmodule Termine.DepletedNodeConsumer do
  use GenStage
  alias Termine.StateHandler
  alias Termine.Worlds

  def start_link(_opts) do
    GenStage.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:consumer, %{}, subscribe_to: [{Termine.PlayerMinerProducerConsumerCalculateReward , max_demand: 20}]}
  end

  def handle_events(events, _, state) do
    Enum.each(events, fn node_id ->
      {:ok, node} = Worlds.find_node(%{id: node_id})
      StateHandler.complete_state(node)
      StateHandler.increment_state(node)
      StateHandler.set_node_to_mining(node.id)
    end)
  end
end