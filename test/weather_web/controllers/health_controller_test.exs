defmodule WeatherWeb.HealthControllerTest do
  use WeatherWeb.ConnCase

  test "GET /health", %{conn: conn} do
    conn = get(conn, "/health")
    assert text_response(conn, 200) =~ "OK"
  end
end
