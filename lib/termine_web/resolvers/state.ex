defmodule TermineWeb.Resolvers.State do
	alias Termine.Worlds
	alias Termine.StateTypes

	def all(params, _), do: Worlds.list_states(params)

	def create(%{type: :block} = params, _) do
		params = params
		|> ids_to_integer([:node_id])
		|> Map.delete(:state_type_object)

		Worlds.create_state(params)
	end

	def create(%{type: state_type, state_type_object: type_object} = params, _) do
		params = params
		|> ids_to_integer([:node_id])
		|> Map.delete(:state_type_object)
		if is_nil(type_object[state_type]) do
			{:error, "type and state_type_object are of different types"}
		else
			{:ok, state} = Worlds.create_state(params)
			create_state_type(state_type, Map.put(type_object[state_type], :state_id, state.id))
			{:ok, state}
		end
	end

	def update(%{id: id} = params, _) do
		params = ids_to_integer(params, [:node_id])
		id = String.to_integer(id)
		Worlds.update_state(id, Map.delete(params, :id))
	end

	defp ids_to_integer(params, ids) do
		params
		|> Map.take(ids)
		|> Enum.reduce(params, fn {key, value}, acc -> Map.put(acc, key, String.to_integer(value)) end)
	end

	defp create_state_type(state_type, params) do
		params = ids_to_integer(params, [:go_to_state_id, :until_state_id, :resource_id])
		case state_type do
			:mineable -> StateTypes.create_collectable(params)
			:attackable -> StateTypes.create_collectable(params)
			:donatable -> StateTypes.create_collectable(params)
			:block_until -> StateTypes.create_block_until(params)
			:loop -> StateTypes.create_loop(params)
			:loop_until -> StateTypes.create_loop_until(params)
		end
	end

end