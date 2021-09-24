defmodule TermineWeb.Types.State do
	use Absinthe.Schema.Notation

	import Absinthe.Resolution.Helpers, only: [dataloader: 1]

	enum :state_type, values: [:mineable, :blocking, :attackable, :donatable]

	object :state do
		field :id, :id
		field :history_text, :string
		field :inspect_text, :string
    	field :resource_amount, :integer
    	field :resource_id, :id
    	field :type, :state_type
    	field :node, :node, resolve: dataloader(Termine.Worlds)
	end
end