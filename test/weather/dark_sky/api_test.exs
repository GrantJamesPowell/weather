defmodule Weather.DarkSky.ApiTest do
  use ExUnit.Case, async: true
  alias Weather.DarkSky.Api

  @success_api_response File.read!("test/support/fixtures/dark_sky_forecast_success.json")

  setup do
    bypass = Bypass.open()
    Process.put("BYPASS_URL", endpoint_url(bypass.port))
    {:ok, bypass: bypass}
  end

  test "calls the dark sky api correctly", %{bypass: bypass} do
    Bypass.expect_once(bypass, fn conn ->
      assert "/API_KEY/0.0,1.0" == conn.request_path
      assert "GET" == conn.method

      Plug.Conn.resp(conn, 200, @success_api_response)
    end)

    assert {:ok, Jason.decode!(@success_api_response)} == Api.forecast("API_KEY", 0.0, 1.0)
  end

  defp endpoint_url(port), do: "http://localhost:#{port}/"
end
