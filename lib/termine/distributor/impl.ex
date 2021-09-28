defmodule Termine.Distributor.Impl do

	alias Termine.Worlds
	
	def initialize_state() do
		{:ok, nodes} = Worlds.list_nodes(%{preload: [miners: [], current_state: [state_type_collectable: [:resource]]]})
		nodes = Enum.reduce(nodes, [], fn x, acc -> 
			if x.state_type === :mineable or x.state_type === :attackable do
				[acc | x]
			else
				acc
			end
		end)
		%{nodes: nodes}
	end
end