defmodule TermineWeb.Types.Miner do
	use Absinthe.Schema.Notation

	object :miner do
		field :id, :id
		field :name, :string
		field :description, :string
	end
end