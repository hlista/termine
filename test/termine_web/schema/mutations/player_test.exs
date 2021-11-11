defmodule TermineWeb.Schema.Mutations.PlayerTest do
  use Termine.DataCase, async: true

  @create_player_doc """
  mutation CreatePlayer($username: String!) {
    createUser(username: $username) {
      id
      username
    }
  }
  """

  @move_player_doc """
  mutation MovePlayer($hash: String!) {
    movePlayer(hash: $hash) {
      id
      username
    }
  }
  """
end