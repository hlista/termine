defmodule TermineWeb.Types.Node do
	use Absinthe.Schema.Notation

	import Absinthe.Resolution.Helpers, only: [dataloader: 1]

	object :node do
		field :id, :id
		field :name, :string
		field :hash, :string
		field :intro_text, :string
		field :current_state, :state, resolve: dataloader(Termine.Worlds)
	end
end