defmodule Termine.Characters do
  alias Termine.Repo
  alias Termine.Characters.{Player, Miner, Inventory, InventoryItem}
  alias EctoShorts.Actions

  def list_players(params) do
    {:ok, Actions.all(Player, params)}
  end

  def create_player(params) do
    [starting_zone | _] = Repo.all(Termine.Worlds.Node)
    params = Map.put(params, :location_id, starting_zone.id)
    Actions.create(Player, params)
  end

  def create_inventory(params) do
    Actions.create(Inventory, params)
  end

  def current_player(user) do
    user = Repo.preload(user, :player)
    {:ok, user.player}
  end

  def move_player(%{hash: hash, user: user}) do
    user = Repo.preload(user, [player: [location: [:neighbor_nodes]]])
    valid_nodes = user.player.location.neighbor_nodes
    case find_valid_node(hash, valid_nodes) do
      nil ->
        {:error, "Cannot travel to that node"}
      node ->
        Actions.update(Player, user.player.id, %{location_id: node.id})
    end

  end

  def find_player(params) do
    Actions.find(Player, params)
  end

  def add_item_to_inventory(inventory_id, 0, amount) do
    {:error}
  end

  def add_item_to_inventory(inventory_id, resource_id, amount) when resource_id > 0 do
    case Actions.find(InventoryItem, %{inventory_id: inventory_id, resource_id: resource_id}) do
      {:ok, inventory_item} ->
        {:ok, Repo.update_all(InventoryItem.query_increment_amount(inventory_item.id, amount), [])}
      {:error, _} ->
        Actions.create(InventoryItem, %{inventory_id: inventory_id, resource_id: resource_id, amount: amount})
    end
  end

  defp find_valid_node(hash, nodes) do
    Enum.find(nodes, fn x -> x.hash === hash end)
  end

end