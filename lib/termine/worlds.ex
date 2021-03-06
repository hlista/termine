defmodule Termine.Worlds do
  alias Termine.Repo
  alias Termine.Worlds.{Node, State, Neighbor}
  alias EctoShorts.Actions
  alias Termine.Redis

  @state_types [:state_type_collectable]

  def list_nodes(params) do
    {:ok, Actions.all(Node, params)}
  end

  def list_nodes_on_states(state_ids) do
    {:ok, Repo.all(Node.nodes_on_states_query(state_ids))}
  end

  def list_states(params) do
    {:ok, Actions.all(State, params)}
  end

  def create_node(params) do
    Actions.create(Node, params)
  end

  def update_node(id, params) do
    Actions.update(Node, id, params)
  end

  def create_state(params) do
    Actions.create(State, params)
  end

  def update_state(id, params) do
    Actions.update(State, id, params)
  end

  def find_state(params) do
    Actions.find(State, params)
  end

  def find_node(params) do
    Actions.find(Node, params)
  end

  def update_state_type(id, params) do
    state = Repo.get(State, id)
    state = Repo.preload(state, @state_types)
    params = update_already_existing_state_type(state, params)
    changeset = Ecto.Changeset.change(state, params)
    Repo.update(changeset)
  end

  def create_neighbor(params) do
    Actions.create(Neighbor, params)
  end

  defp update_already_existing_state_type(state, params) do
    Enum.reduce(params, params, fn {state_type, value}, acc ->
      type = get_in(state, [Access.key(state_type)])
      if type do
        Repo.update(Ecto.Changeset.change(type, value))
        Map.delete(acc, state_type)
      else
        acc
      end
    end)
  end
end