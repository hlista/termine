defmodule Termine.Repo do
  use Ecto.Repo,
    otp_app: :termine,
    adapter: Ecto.Adapters.Postgres
end
