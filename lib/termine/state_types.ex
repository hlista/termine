defmodule Termine.StateTypes do
	alias Termine.Repo
	alias Termine.StateTypes.{BlockUntil, Collectable, Loop, LoopUntil}
	alias EctoShorts.Actions

	def create_block_until(params) do
		Actions.create(BlockUntil, params)
	end

	def create_collectable(params) do
		Actions.create(Collectable, params)
	end

	def create_loop(params) do
		Actions.create(Loop, params)
	end

	def create_loop_until(params) do
		Actions.create(LoopUntil, params)
	end
end