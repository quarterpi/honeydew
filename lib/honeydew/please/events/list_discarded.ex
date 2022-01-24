defmodule Honeydew.Please.Events.ListDiscarded do
  @moduledoc """
  Event that signals a list was discarded.
  """

  @derive Jason.Encoder

  defstruct [
    :list_id,
    :notes
  ]
end
