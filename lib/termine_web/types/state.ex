defmodule TermineWeb.Types.State do
	use Absinthe.Schema.Notation

	enum :state_type, values: [:mineable, :blocking, :attackable, :donatable]

	object :state do
		field :history_text, :string
		field :inspect_text, :string
    	field :resource_amount, :integer
    	field :type, :state_type
	end
end