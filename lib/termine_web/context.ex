defmodule Termine.Context do
	@behaviour Plug

	import Plug.Conn

	alias Termine.Accounts

	def init(opts), do: opts

	def call(conn, _) do
		current_user = conn
		|> get_session(:user_token)
		|> Accounts.get_user_by_session_token()

		Absinthe.Plug.put_options(conn, context: %{current_user: current_user})
	end
end