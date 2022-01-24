defmodule Honeydew.Please.Events.ListAdded do
  @moduledoc """
  Event that signals a list was completed.
  """

  @derive Jason.Encoder

  defstruct [
    :list_id,
    :notes
  ]
end
