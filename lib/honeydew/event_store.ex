defmodule Honeydew.EventStore do
  @moduledoc """
  The Commanded EventStore.
  """

  use EventStore,
    otp_app: :honeydew,
    serializer: Commanded.Serialization.JsonSerializer

  # Optionally modify config at runtime.
  def init(config) do
    {:ok, config}
  end
end
