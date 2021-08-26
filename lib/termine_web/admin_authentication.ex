defmodule TermineWeb.AdminAuthentication do
	@behaviour Absinthe.Middleware

	def call(resolution, _config) do
		case resolution.context do
			%{current_user: %{role: :admin}} ->
				resolution
			_ ->
				resolution
				|> Absinthe.Resolution.put_result({:error, "You must be admin to access this API call"})
		end
	end
end