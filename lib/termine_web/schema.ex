defmodule TermineWeb.Schema do
	use Absinthe.Schema

	import_types TermineWeb.Types.Player

	import_types TermineWeb.Schema.Mutations.Player

	import_types TermineWeb.Schema.Queries.Player

	query do
		import_fields :player_queries
	end

	mutation do
		import_fields :player_mutations
	end
end