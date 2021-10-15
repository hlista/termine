defmodule Termine.Miners do
	alias Termine.Repo
	alias Termine.Miners.{Miner, PlayerMiner, Expertise}
	alias EctoShorts.Actions
	alias Termine.Redis

	def create_miner(params) do
		Actions.create(Miner, params)
	end

	def send_player_miner(current_user, params) do
		current_user = Repo.preload(current_user, [player: [location: [:current_state], player_miners: [:expertises]]])
		state_type = current_user.player.location.current_user.type
		player_miner = Enum.find(current_user.player.player_miners, fn player_miner -> player_miner.id === params.id end)

		cond do
			state_type !== :mineable and state_type !== :attackable ->
				{:error, "This node is not mineable at the moment"}
			is_nil(player_miner) ->
				{:error, "You do not own that miner"}
			true ->
				Redis.zero_player_miners_hits(Integer.to_string(current_user.player.location_id), Integer.to_string(player_miner.id))
				Redis.set_all_player_miners_expertises(Integer.to_string(player_miner.id), player_miner.expertises)
				Actions.update(PlayerMiner, player_miner, location_id: current_user.player.location_id)
		end
	end
end