# Honeydew

An example app built on the CELP (Commanded, Elixir, LiveView, PostgreSQL) stack.

Use this example "Honey Do" list app to experiment with CQRS/ES in Commanded. The domain is pretty simple.
It's a todo list with a little extra sauce allowing developers lots of creative freedom.

https://user-images.githubusercontent.com/12484828/155138450-ca6f2787-12e4-49cf-87f7-67884dd7bc34.mp4

## Setup
You'll need to have PostgreSQL setup and running on your machine. My favourite way to get PostgreSQL setup is via Docker Desktop. Once you have docker installed, you can use this command to get PostgreSQL setup on your machine.

`docker run --rm --name pg-docker -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 postgres`

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

This app is not ready for production. 

## Blunt (Formerly CQRS_TOOLS)
For an example of this app ported to use `blunt` (Formerly `cqrs_tools`) checkout the `with_cqrs_tools` branch!

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
  * Commanded: https://hexdocs.pm/commanded/1.2.0/Commanded.html


This is a SUPER rough example meant to get you started without much hassle. It's not meant to be a complete guide. 

If you have any questions, feel free to reach out to me: 
  * on the Elixir Slack @threequarterspi.
  * on twitter @threequarterspi
  * on github @quarterpi

