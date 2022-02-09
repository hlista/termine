defmodule Termine.Miners do
  alias Termine.Repo
  alias Termine.Miners.{Miner, PlayerMiner}
  alias EctoShorts.Actions
  alias Termine.Redis

  def get_player_miners_for_mining(limit) do
    Repo.transaction(fn ->
      player_miners = Actions.all(PlayerMiner.get_player_miners_lock_query(limit), preload: [:inventory])
      ids = Enum.map(player_miners, fn pm -> pm.id end)
      Repo.update_all(PlayerMiner.player_miners_query(ids), set: [pending: false])
      player_miners
    end)
  end

  def player_miners_finished_mining(player_miners, timestamp) do
    ids = Enum.map(player_miners, fn pm -> pm.id end)
    Repo.update_all(PlayerMiner.player_miners_query(ids), set: [pending: true, last_time_mined: timestamp])
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
        Actions.update(PlayerMiner, player_miner, %{location_id: current_user.player.location_id, last_time_mined: DateTime.utc_now()})
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