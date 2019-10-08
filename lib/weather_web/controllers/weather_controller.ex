defmodule WeatherWeb.WeatherController do
  use WeatherWeb, :controller
  alias Weather.DarkSky.Api

  def weather(conn, %{"latitude" => lat, "longitude" => lon}) do
    case {Float.parse(lat), Float.parse(lon)} do
      {{lat, ""}, {lon, ""}} ->
        case Api.forecast(api_key(), lat, lon) do
          {:ok, forecast} ->
            json(conn, forecast)

          {:error, _} ->
            api_unavailable(conn)
        end

      _ ->
        invalid_parameters(conn)
    end
  end

  def weather(conn, _params), do: invalid_parameters(conn)

  defp api_unavailable(conn) do
    conn
    |> put_status(500)
    |> json(%{
      error: "API currently unavailable"
    })
  end

  defp invalid_parameters(conn) do
    conn
    |> put_status(422)
    |> json(%{
      error:
        "invalid input, requests must include both latitude and longitude parameters that are parsable numbers"
    })
  end

  defp api_key do
    Application.get_env(:weather, :dark_sky_api_key)
  end
end
