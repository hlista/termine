defmodule TermineWeb.Types.Neighbor do
	use Absinthe.Schema.Notation

	import Absinthe.Resolution.Helpers, only: [dataloader: 1]

	object :neighbor do
		field :child_node, :node, resolve: dataloader(Termine.Worlds)
		field :parent_node, :node, resolve: dataloader(Termine.Worlds)
	end
end