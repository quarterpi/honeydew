defmodule Honeydew.Please.Events.ListMade do
  @moduledoc """
  Event that signals a new list was made.
  """

  @derive Jason.Encoder

  defstruct [
    :list_id,
    :name,
    :notes
  ]
end
