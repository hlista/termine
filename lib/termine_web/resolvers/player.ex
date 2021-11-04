defmodule TermineWeb.Resolvers.Player do
  alias Termine.Characters

  def all(params, _), do: Characters.list_players(params)

  def create(params, %{context: %{current_user: current_user}}) do
    created_player = params
    |> Map.put(:user_id, current_user.id)
    |> Characters.create_player()
    case created_player do
      {:ok, player} ->
        Characters.create_inventory(%{player_id: player.id})
        {:ok, player}
      {:error, error} ->
        {:error, error}
    end
  end

  def move(params, %{context: %{current_user: user}}) do
    params
    |> Map.put(:user, user)
    |> Characters.move_player()
  end
end