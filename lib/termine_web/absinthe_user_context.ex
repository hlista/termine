defmodule Termine.AbsintheUserContext do
	@behaviour Plug

	import Plug.Conn

	alias Termine.Accounts

	def init(opts), do: opts

	def call(conn, _) do
		Absinthe.Plug.put_options(conn, context: %{current_user: conn.assigns.current_user})
	end
end