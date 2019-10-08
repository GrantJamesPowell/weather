defmodule Weather.DarkSky.Api do
  @base_url "https://api.darksky.net/forecast/"

  @doc """
  Returns the current forecast for the next week
  """
  def forecast(api_key, latitude, longitude) do
    case HTTPoison.get("#{base_url()}#{api_key}/#{latitude},#{longitude}") do
      {:ok, forecast} ->
        Jason.decode(forecast.body)

      {:error, error} ->
        {:error, error}
    end
  end

  def base_url, do: Process.get("BYPASS_URL") || @base_url
end
