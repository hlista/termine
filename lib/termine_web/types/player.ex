defmodule TermineWeb.Types.Player do
	use Absinthe.Schema.Notation

	object :player do
		field :username, :string
	end
end