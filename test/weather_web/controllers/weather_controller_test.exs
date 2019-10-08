defmodule WeatherWeb.WeatherControllerTest do
  use WeatherWeb.ConnCase
  use ExUnit.Case, async: true
  import ExUnit.CaptureLog

  @success_api_response File.read!("test/support/fixtures/dark_sky_forecast_success.json")
  @invalid_credential_api_response File.read!(
                                     "test/support/fixtures/dark_sky_forecast_invalid_credentials.json"
                                   )

  setup do
    bypass = Bypass.open()
    Process.put("BYPASS_URL", endpoint_url(bypass.port))
    {:ok, bypass: bypass}
  end

  describe "GET /weather" do
    test "requires both the latitude and longitude parameters", %{conn: conn} do
      conn = get(conn, "/weather")

      assert json_response(conn, 422) == %{
               "error" =>
                 "invalid input, requests must include both latitude and longitude parameters that are parsable numbers"
             }
    end

    test "fails if the latitiude parameter is missing", %{conn: conn} do
      conn = get(conn, "/weather?longitude=1")

      assert json_response(conn, 422) == %{
               "error" =>
                 "invalid input, requests must include both latitude and longitude parameters that are parsable numbers"
             }
    end

    test "fails if the longitude parameter is missing", %{conn: conn} do
      conn = get(conn, "/weather?latitude=1")

      assert json_response(conn, 422) == %{
               "error" =>
                 "invalid input, requests must include both latitude and longitude parameters that are parsable numbers"
             }
    end

    test "if fail if the latitude and longitude aren't valid numbers", %{conn: conn} do
      conn = get(conn, "/weather?latitude=abc&longitude=def")

      assert json_response(conn, 422) == %{
               "error" =>
                 "invalid input, requests must include both latitude and longitude parameters that are parsable numbers"
             }
    end

    test "if the unstream is unavailable it returns a 500", %{conn: conn, bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert "/NOT_A_REAL_API_KEY/1.0,2.0" == conn.request_path
        Plug.Conn.resp(conn, 403, @invalid_credential_api_response)
      end)

      assert capture_log(fn ->
               conn = get(conn, "/weather?latitude=1.0&longitude=2.0")
               assert json_response(conn, 500) == %{"error" => "API currently unavailable"}
             end) =~ "Invalid Credentials Sent to Dark Sky"
    end

    test "if the unstream is available it returns a 200 with the correct data", %{
      conn: conn,
      bypass: bypass
    } do
      Bypass.expect_once(bypass, fn conn ->
        assert "/NOT_A_REAL_API_KEY/1.0,2.0" == conn.request_path
        Plug.Conn.resp(conn, 200, @success_api_response)
      end)

      conn = get(conn, "/weather?latitude=1.0&longitude=2.0")
      assert json_response(conn, 200) == Jason.decode!(@success_api_response)
    end
  end

  defp endpoint_url(port), do: "http://localhost:#{port}/"
end
