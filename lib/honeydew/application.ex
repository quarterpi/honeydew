defmodule Honeydew.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Commanded Application
      Honeydew.App,
      # Start the Ecto repository
      Honeydew.Repo,
      # Start the Telemetry supervisor
      HoneydewWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Honeydew.PubSub},
      # Start the Endpoint (http/https)
      HoneydewWeb.Endpoint
      # Start a worker by calling: Honeydew.Worker.start_link(arg)
      # {Honeydew.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Honeydew.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HoneydewWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
