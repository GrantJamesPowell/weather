# Grant Powell's SalesLoft Engineering Enablement Coding Challenge

To start the weather API server locally:

  * Ensure you have the correct Elixir, Erlang, NodeJs versions locally (check the .tool-versions)
  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `DARK_SKY_API_KEY=your_api_key_here mix phx.server`
  * You can now hit `http://localhost:4000/weather?latitude=1.0&longitude=2.0` and get weather data back!

Running the spec suite

`mix test`

# What should I be looking at?

This PR shows the building of a wrapper around the Dark Sky API
  - https://github.com/GrantJamesPowell/weather/pull/1

This PR shows building a controller to parse user input and then call the Dark Sky API
  - https://github.com/GrantJamesPowell/weather/pull/2

This PR shows the making of a mix release and a dockerfile
  - https://github.com/GrantJamesPowell/weather/pull/5

This PR shows adding a circle CI config to run the spec suite and the formatter
  - https://github.com/GrantJamesPowell/weather/pull/6

This PR shows adding kubernetes files
  - https://github.com/GrantJamesPowell/weather/pull/7
