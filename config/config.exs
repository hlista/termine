# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :termine,
  ecto_repos: [Termine.Repo]

config :ecto_shorts,
  repo: Termine.Repo,
  error_module: EctoShorts.Actions.Error

# Configures the endpoint
config :termine, TermineWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "jGtYshQWSyTMSHFLAv81ZzxDY3TUdswv3+709o9Is2f4SGGuq4oGg9dpyCZjRgom",
  render_errors: [view: TermineWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Termine.PubSub,
  live_view: [signing_salt: "qxeTXsMi"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
