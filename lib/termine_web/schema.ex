defmodule TermineWeb.Schema do
	use Absinthe.Schema

	import_types TermineWeb.Types.Player
	import_types TermineWeb.Types.Node
	import_types TermineWeb.Types.State
	import_types TermineWeb.Types.Neighbor
	import_types TermineWeb.Types.Miner

	import_types TermineWeb.Schema.Mutations.Player
	import_types TermineWeb.Schema.Mutations.Node
	import_types TermineWeb.Schema.Mutations.State
	import_types TermineWeb.Schema.Mutations.Neighbor
	import_types TermineWeb.Schema.Mutations.Miner

	import_types TermineWeb.Schema.Queries.Player
	import_types TermineWeb.Schema.Queries.Node
	import_types TermineWeb.Schema.Queries.State

	query do
		import_fields :player_queries
		import_fields :node_queries
		import_fields :state_queries
	end

	mutation do
		import_fields :player_mutations
		import_fields :node_mutations
		import_fields :state_mutations
		import_fields :neighbor_mutations
		import_fields :miner_mutations
	end

	def context(ctx) do
		source = Dataloader.Ecto.new(Termine.Repo)
		dataloader = 
			Dataloader.add_source(Dataloader.new(), Termine.Worlds, source)
			|> Dataloader.add_source(Termine.Characters, source)
			|> Dataloader.add_source(Termine.StateTypes, source)

		Map.put(ctx, :loader, dataloader)
	end

	def plugins do
		[Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
	end
end