defmodule TermineWeb.Resolvers.Node do
  alias Termine.Worlds

  def all(params, _), do: Worlds.list_nodes(params)

  def create(params, _) do
    ids_to_integer(params)
    |> Map.put(:hash, generate_hash())
    |> Worlds.create_node()
  end

  def update(%{id: id} = params, _) do
    params = ids_to_integer(params)
    id = String.to_integer(id)
    Worlds.update_node(id, Map.delete(params, :id))
  end

  defp generate_hash() do
    for _ <- 1..6, into: "", do: <<Enum.random('0123456789abcdefghijklmnopqrstuvwxyz')>>
  end

  defp ids_to_integer(params) do
    params
    |> Map.take([:current_state_id, :state_id_array])
    |> Enum.reduce(params, fn {key, value}, acc -> 
      cond do
        is_list(value) -> Map.put(acc, key, Enum.map(value, fn x -> String.to_integer(x) end))
        is_binary(value) -> Map.put(acc, key, String.to_integer(value))
      end
    end)
  end
end