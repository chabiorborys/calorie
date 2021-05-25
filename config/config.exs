# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :calorie,
  ecto_repos: [Calorie.Repo]

# Configures the endpoint
config :calorie, CalorieWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Tzqy+2lVE7aNKWN61ixxlU+4uFPrabZXjz93IVJyg3FFBpCLrSUxMApsa20DTVDY",
  render_errors: [view: CalorieWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Calorie.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "/KK4qle9"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
