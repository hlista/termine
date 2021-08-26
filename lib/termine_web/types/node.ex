defmodule TermineWeb.Types.Node do
	use Absinthe.Schema.Notation

	object :node do
		field :name, :string
		field :hash, :string
	end
end