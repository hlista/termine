defmodule TermineWeb.Resolvers.State do
  alias Termine.Worlds
  alias Termine.StateTypes

  @state_types [:state_type_collectable]
  @ids [:node_id, :go_to_state_id, :until_state_id, :resource_id]

  def all(params, _), do: Worlds.list_states(params)

  def create(%{type: :block} = params, _) do
    params = params
    |> ids_to_integer([:node_id])
    |> Map.delete(:state_type_object)

    Worlds.create_state(params)
  end

  def create(params, _) do
    params = ids_to_integer(params, [:node_id])

    Worlds.create_state(params)
  end

  def update(%{id: id} = params, _) do
    params = ids_to_integer(params, [:node_id])
    id = String.to_integer(id)
    Worlds.update_state(id, Map.delete(params, :id))
  end

  def update_type(%{state_id: id} = params, _) do
    id = String.to_integer(id)
    if (Map.has_key?(params, :type)) do
      Worlds.update_state(id, %{type: params[:type]})
    end
    params = params
    |> Map.drop([:state_id, :type])
    |> state_type_ids_to_integer(@state_types, @ids)
    Worlds.update_state_type(id, params)
  end

  defp state_type_ids_to_integer(params, state_types, ids) do
    params
    |> Map.take(state_types)
    |> Enum.reduce(params, fn {key, value}, acc ->
      Map.put(acc, key, ids_to_integer(value, ids))
    end)
  end

  defp ids_to_integer(params, ids) do
    params
    |> Map.take(ids)
    |> Enum.reduce(params, fn {key, value}, acc ->
      Map.put(acc, key, String.to_integer(value))
    end)
  end

end