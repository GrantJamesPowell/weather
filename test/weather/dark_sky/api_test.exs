defmodule Weather.DarkSky.ApiTest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureLog
  require Logger

  alias Weather.DarkSky.Api

  @success_api_response File.read!("test/support/fixtures/dark_sky_forecast_success.json")
  @invalid_credential_api_response File.read!(
                                     "test/support/fixtures/dark_sky_forecast_invalid_credentials.json"
                                   )

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

  test "when the dark sky api returns unauthorized, the api returns that correctly", %{
    bypass: bypass
  } do
    Bypass.expect_once(bypass, fn conn ->
      assert "/API_KEY/0.0,1.0" == conn.request_path
      assert "GET" == conn.method

      Plug.Conn.resp(conn, 403, @invalid_credential_api_response)
    end)

    assert capture_log(fn ->
             assert {:error, :invalid_credentials} == Api.forecast("API_KEY", 0.0, 1.0)
           end) =~ "Invalid Credentials Sent to Dark Sky"
  end

  defp endpoint_url(port), do: "http://localhost:#{port}/"
end
