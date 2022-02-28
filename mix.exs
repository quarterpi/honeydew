defmodule Honeydew.MixProject do
  use Mix.Project

  def project do
    [
      app: :honeydew,
      version: "0.1.0",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:gettext] ++ Mix.compilers() ++ [:surface],
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      docs: [
        main: "overview",
        api_reference: false,
        assets: "guides/assets",
        extra_section: "GUIDES",
        extras: ["guides/overview.md"],
        nest_modules_by_prefix: [
          Honeydew.Please.Commands,
          Honeydew.Please.Events,
          Honeydew.Please.Queries,
          Honeydew.Please.Projections,
          Honeydew.Please.Projectors
        ],
        groups_for_modules: [
          Contexts: [Honeydew.Please],
          Aggregates: [Honeydew.Please.List, Honeydew.Please.Task],
          Commands: ~r(Honeydew.Please.Commands)i,
          Events: ~r(Honeydew.Please.Events)i,
          Queries: ~r(Honeydew.Please.Queries)i,
          "Read Model": [Honeydew.Repo, ~r(Honeydew.Please.Project[ors|ions])i],
          "Blunt Config": ~r(Honeydew.Blunt)i,
          Utils: [Honeydew.CustomId],
          Commanded: [Honeydew.App, Honeydew.EventStore, Honeydew.Router],
          Phoenix: ~r(HoneydewWeb)i
        ]
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Honeydew.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.6.0"},
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.6"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.16.0"},
      {:floki, ">= 0.30.0", only: :test},
      {:phoenix_live_dashboard, "~> 0.5"},
      {:esbuild, "~> 0.2", runtime: Mix.env() == :dev},
      {:swoosh, "~> 1.3"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.18"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.5"},
      {:commanded, "~> 1.3"},
      {:eventstore, "~> 1.3"},
      {:commanded_eventstore_adapter, "~> 1.2"},
      {:commanded_ecto_projections, "~> 1.2"},
      {:typed_struct, "~> 0.2.1"},
      {:exconstructor, "~> 1.2.4"},
      {:surface, "~> 0.6.1"},
      {:base62, "~> 1.2"},
      {:surface_formatter, "~> 0.6.0"},

      # blunt
      {:blunt, "~> 0.1"},
      {:blunt_ddd, "~> 0.1"},

      # Docs
      {:ex_doc, "~> 0.28", only: :dev, runtime: false},

      # testing
      {:faker, "~> 0.17.0", only: :test},
      {:ex_machina, "~> 2.7", only: :test},
      {:elixir_uuid, "~> 1.6", override: true, hex: :uuid_utils},
      {:blunt_toolkit, github: "blunt-elixir/blunt_toolkit", runtime: false, only: :dev}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "event_store.init": ["event_store.drop", "event_store.create", "event_store.init"],
      reset: ["event_store.init", "ecto.reset"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.deploy": ["esbuild default --minify", "phx.digest"],
      view_state: "blunt.inspect.aggregate"
    ]
  end
end
