use Mix.Config

# Configures the endpoint
config :weather, WeatherWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "D4J/ZrKH/384ND38l0Y+j+5PHP664OYZbjoJEqIbFuuCljx2JlMvW6dQ7nxB1kwc",
  render_errors: [view: WeatherWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Weather.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :weather, dark_sky_api_key: System.get_env("DARK_SKY_API_KEY")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
