defmodule Termine.Miners do
	alias Termine.Repo
	alias Termine.Miners.{Miner, PlayerMiner, Expertise}
	alias EctoShorts.Actions

	def create_miner(params) do
		Actions.create(Miner, params)
	end

	def send_player_miner(current_user, params) do
		current_user = Repo.preload(current_user, [player: [location: [], player_miners: []]])
		player_miner = Enum.find(current_user.player.player_miners, fn player_miner -> player_miner.id === params.id end)
		
		case player_miner do
			nil -> {:error, "You do not own that miner"}
			_ -> Actions.update(PlayerMiner, player_miner, location_id: current_user.player.location_id)
		end
	end
end