# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :blunt,
  context_shipper: nil,
  log_when_compiling: false,
  dispatch_return: :response,
  create_jason_encoders: true,
  dispatch_strategy: Blunt.DispatchStrategy.Default,
  pipeline_resolver: Honeydew.Blunt.PipelineResolver

config :commanded, event_store_adapter: Commanded.EventStore.Addapters.EventStore

config :commanded_ecto_projections, repo: Honeydew.Repo

config :honeydew,
  event_stores: [Honeydew.EventStore]

config :honeydew,
  ecto_repos: [Honeydew.Repo]

# Configures the endpoint
config :honeydew, HoneydewWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: HoneydewWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Honeydew.PubSub,
  live_view: [signing_salt: "i7otJMPq"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :honeydew, Honeydew.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args: ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :surface, :components, [
  {Surface.Components.Form.ErrorTag,
   default_translator: {HoneydewWeb.ErrorHelpers, :translate_error}}
]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
