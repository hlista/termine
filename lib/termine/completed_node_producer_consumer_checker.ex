defmodule Termine.CompletedNodeProducerConsumerChecker do
  use GenStage

  def start_link(_opts) do
    GenStage.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:producer_consumer, %{}, subscribe_to: [{Termine.CompletedNodeProducer, max_demand: 20}]}
  end

  def handle_events(events, _from, state) do
    
  end
  
end