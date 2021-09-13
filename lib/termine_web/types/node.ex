defmodule TermineWeb.Types.Node do
	use Absinthe.Schema.Notation

	object :node do
		field :id, :id
		field :name, :string
		field :hash, :string
		field :intro_text, :string
		field :state_id, :id
	end
end