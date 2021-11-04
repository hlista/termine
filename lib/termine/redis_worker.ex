defmodule Termine.RedisWorker do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    {:ok, conn} = Redix.start_link()
    {:ok, %{conn: conn}}
  end

  def handle_call({:command, array}, _from, state = %{conn: conn}) do
    {:reply, Redix.command(conn, array), state}
  end
end