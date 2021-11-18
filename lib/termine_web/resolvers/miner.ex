defmodule TermineWeb.Resolvers.Miner do
  alias Termine.Miners

  def create(params, _) do
    Miners.create_miner(params)
  end

  def send(params, %{context: %{current_user: current_user}}) do
    params = %{params | id: String.to_integer(params.id)}

    Miners.send_player_miner(current_user, params)
  end

  def retreat(params, %{context: %{current_user: current_user}}) do
    params = %{params | id: String.to_integer(params.id)}

    Miners.retreat_player_miner(current_user, params)
  end
end