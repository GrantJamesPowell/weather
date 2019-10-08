defmodule Weather.DarkSky.Api do
  require Logger
  @base_url "https://api.darksky.net/forecast/"

  @doc """
  Returns the current forecast for the next week
  """
  def forecast(api_key, latitude, longitude) do
    case HTTPoison.get("#{base_url()}#{api_key}/#{latitude},#{longitude}") do
      {:ok, %{status_code: 200, body: body}} ->
        Jason.decode(body)

      {:ok, %{status_code: 403}} ->
        Logger.warn("Invalid Credentials Sent to Dark Sky")
        {:error, :invalid_credentials}

      {:error, error} ->
        {:error, error}
    end
  end

  def base_url, do: Process.get("BYPASS_URL") || @base_url
end
