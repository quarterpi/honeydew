defmodule Honeydew.App do
  @moduledoc """
  The Commanded App.
  """

  use Commanded.Application,
    otp_app: :honeydew,
    event_store: [
      adapter: Commanded.EventStore.Adapters.EventStore,
      event_store: Honeydew.EventStore
    ],
    default_dispatch_opts: [
      returning: :execution_result
    ],
    pubsub: [
      phoenix_pubsub: [
        adapter: Phoenix.PubSub.PG2,
        pool_size: 1
      ]
    ],
    registry: :local

  router(Honeydew.Router)
end
