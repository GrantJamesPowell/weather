defmodule WeatherWeb.HealthController do
  use WeatherWeb, :controller

  def health(conn, _params) do
    text(conn, "OK")
  end
end
