# Build Stage
FROM elixir:1.9-slim AS builder

MAINTAINER the-notorious-gjp

WORKDIR /app
ENV MIX_ENV=prod

RUN apt-get update && \
  apt-get install -y curl git && \
  curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
  apt-get install -y inotify-tools nodejs

RUN mix local.hex --force && \
  mix local.rebar --force

COPY mix.exs mix.lock ./

RUN mix deps.get --only prod
RUN mix deps.compile

COPY assets/package.json assets/package-lock.json ./assets/
RUN cd assets && npm install

COPY assets/ assets/
RUN cd assets && npm run deploy

COPY . .

RUN mix phx.digest
RUN mix release --overwrite

# # Deploy Stage
FROM elixir:1.9-slim
ENV MIX_ENV=prod

WORKDIR /app

COPY --from=builder /app/_build/prod/rel .

CMD ["weather/bin/weather", "start"]
