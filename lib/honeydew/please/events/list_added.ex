defmodule Honeydew.Please.Events.ListAdded do
  @moduledoc """
  Event that signals a new list was added.
  """

  @derive Jason.Encoder

  defstruct [
    :list_id,
    :name,
    :notes
  ]
end
