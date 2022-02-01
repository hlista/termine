defmodule Termine.PlayerMinerTimestampCache do
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

  def set(name \\ @default_name, key, value) do
    :ets.insert(name, {key, value})
  end

  def get(name \\ @default_name, key, default_value \\ 0) do
    case :ets.lookup(name, key) do
      [{^key, val}] -> val
      _ -> default_value
    end
  end

  def get_and_set(name \\ @default_name, key, value) do
    case :ets.lookup(name, key) do
      [{^key, val}] ->
        set(key, value)
        val
      _ ->
        set(key, value)
        value
    end
  end
end