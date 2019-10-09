# Engineering Enablement Coding Challenge

To start the weather API server locally:

  * Ensure you have the correct Elixir, Erlang, NodeJs versions locally (check the .tool-versions)
  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `DARK_SKY_API_KEY=your_api_key_here mix phx.server`
  * You can now hit `http://localhost:4000/weather?latitude=1.0&longitude=2.0` and get weather data back!

## Running the spec suite

```
mix test
```

# What should I be looking at?

Building of a wrapper around the Dark Sky API
  - https://github.com/GrantJamesPowell/weather/pull/1

Controller to parse user input and then call the Dark Sky API
  - https://github.com/GrantJamesPowell/weather/pull/2

Making of a Mix release and a Dockerfile
  - https://github.com/GrantJamesPowell/weather/pull/5

Circle CI config to run the spec suite and the formatter
  - https://github.com/GrantJamesPowell/weather/pull/6

Kubernetes Config
  - https://github.com/GrantJamesPowell/weather/pull/7

Adding the Health Controller
  - https://github.com/GrantJamesPowell/weather/pull/8

Getting the Release to Read ENVs are runtime correctly (messed this up in pull request 5 🤦)
  - https://github.com/GrantJamesPowell/weather/pull/9

# Is there a place I can try it?

Yep! Checkout 
```
https://weather.grantjamespowell.com/weather?latitude=1.0&longitude=1.0
```
(It requires a username and password which is available through other channels)
