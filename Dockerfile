FROM hexpm/elixir:1.16.0-rc.0-erlang-26.1.2-ubuntu-focal-20231003
WORKDIR /app

ENV TZ=Asia/Tokyo
ENV ERL_FLAGS="+JMsingle true"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y \
  inotify-tools \
  git \
  npm \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN mix do \
  local.hex --force, \
  archive.install hex phx_new --force, \
  local.rebar --force

ADD . .


