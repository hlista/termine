defmodule TermineWeb.Resolvers.Resource do
	alias Termine.Items

	def create(params, _) do
		Items.create_resource(params)
	end
end