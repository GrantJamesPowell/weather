use Mix.Config

config :weather, WeatherWeb.Endpoint,
  url: [host: "weather.grantjamespowell.com", port: 443],
  cache_static_manifest: "priv/static/cache_manifest.json",
  server: true

config :logger, level: :info
