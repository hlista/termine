defmodule TermineWeb.Types.State do
	use Absinthe.Schema.Notation

	import Absinthe.Resolution.Helpers, only: [dataloader: 1]

	enum :state_type, values: [:mineable, :attackable, :donatable, :block, :block_until, :loop, :loop_until]

	object :state do
		field :id, :id
		field :inspect_text, :string
    	field :type, :state_type
    	field :node, :node, resolve: dataloader(Termine.Worlds)

    	field :state_type_collectable, :state_type_collectable, resolve: dataloader(Termine.StateTypes)
    	field :state_type_block_until, :state_type_block_until, resolve: dataloader(Termine.StateTypes)
    	field :state_type_loop, :state_type_loop, resolve: dataloader(Termine.StateTypes)
    	field :state_type_loop_until, :state_type_loop_until, resolve: dataloader(Termine.StateTypes)
	end

	object :state_type_collectable do
		field :amount, :integer
		field :resource_id, :id
	end

	object :state_type_block_until do
		field :until_state_id, :id
	end

	object :state_type_loop do
		field :go_to_state_id, :id
	end

	object :state_type_loop_until do
		field :go_to_state_id, :id
		field :until_state_id, :id
	end

	input_object :input_state_type_object do
		field :mineable, :input_state_type_mineable
		field :attackable, :input_state_type_attackable
		field :donatable, :input_state_type_donatable
		field :block_until, :input_state_type_block_until
		field :loop, :input_state_type_loop
		field :loop_until, :input_state_type_loop_until
	end

	input_object :input_state_type_mineable do
		field :amount, :integer
		field :resource_id, :id
	end

	input_object :input_state_type_attackable do
		field :amount, :integer
		field :resource_id, :id
	end

	input_object :input_state_type_donatable do
		field :amount, :integer
		field :resource_id, :id
	end

	input_object :input_state_type_block_until do
		field :until_state_id, :id
	end

	input_object :input_state_type_loop do
		field :go_to_state_id, :id
	end

	input_object :input_state_type_loop_until do
		field :go_to_state_id, :id
		field :until_state_id, :id
	end
end