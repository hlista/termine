defmodule TermineWeb.Schema do
	use Absinthe.Schema

	import_types TermineWeb.Types.Player
	import_types TermineWeb.Types.Node
	import_types TermineWeb.Types.State

	import_types TermineWeb.Schema.Mutations.Player
	import_types TermineWeb.Schema.Mutations.Node
	import_types TermineWeb.Schema.Mutations.State
	import_types TermineWeb.Schema.Mutations.Neighbor

	import_types TermineWeb.Schema.Queries.Player

	query do
		import_fields :player_queries
	end

	mutation do
		import_fields :player_mutations
		import_fields :node_mutations
		import_fields :state_mutations
		import_fields :neighbor_mutations
	end
end