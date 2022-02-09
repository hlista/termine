defmodule Termine.Miners do
  alias Termine.Repo
  alias Termine.Miners.{Miner, PlayerMiner}
  alias EctoShorts.Actions
  alias Termine.Redis

  def list_player_miners_currently_mining(params \\ %{}) do
    {:ok, Actions.all(PlayerMiner.player_miners_with_location_query(), params)}
  end

  def create_miner(params) do
    Actions.create(Miner, params)
  end

  def create_starter_player_miner(%{player_id: id}) do
    [starter_miner | _] = Repo.all(Miner)
    Actions.create(PlayerMiner, %{player_id: id, miner_id: starter_miner.id})
  end

  def send_player_miner(current_user, params) do
    current_user = Repo.preload(current_user, [player: [location: [:current_state], player_miners: [], inventory: []]])
    state_type = current_user.player.location.current_state.type
    player_miner = Enum.find(current_user.player.player_miners, fn player_miner -> player_miner.id === params.id end)

    cond do
      state_type !== :mineable and state_type !== :attackable ->
        {:error, "This node is not mineable at the moment"}
      is_nil(player_miner) ->
        {:error, "You do not own that miner"}
      !is_nil(player_miner.location_id) ->
        {:error, "miner is somewhere else"}
      true ->
        #Redis.set_player_miner_to_mining(Integer.to_string(current_user.player.location_id), Integer.to_string(player_miner.id), player_miner.expertises, Integer.to_string(current_user.player.inventory.id))
        Actions.update(PlayerMiner, player_miner, location_id: current_user.player.location_id)
    end
  end

  def retreat_player_miner(current_user, params) do
    current_user = Repo.preload(current_user, [player: [:player_miners]])
    player_miner = Enum.find(current_user.player.player_miners, fn player_miner -> player_miner.id === params.id end)
    cond do
      is_nil(player_miner) ->
        {:error, "You do not own that miner"}
      true ->
        #Redis.delete_player_miners_hits(Integer.to_string(current_user.player.location_id), Integer.to_string(player_miner.id))
        Actions.update(PlayerMiner, player_miner, location_id: nil)
    end
  end
end