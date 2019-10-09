import Config

config :weather, WeatherWeb.Endpoint,
  secret_key_base: System.fetch_env!("SECRET_KEY_BASE"),
  http: [port: System.get_env("PORT") || 4000],
  server: true

config :weather, dark_sky_api_key: System.fetch_env!("DARK_SKY_API_KEY")
