defmodule TermineWeb.Types.Resource do
	use Absinthe.Schema.Notation

	object :resource do
		field :name, :string
		field :id, :id
	end
end