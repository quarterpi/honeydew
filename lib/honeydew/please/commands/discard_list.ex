defmodule Honeydew.Please.Commands.DiscardList do
  @moduledoc """
  Command to mark list as discarded.
  """

  defstruct [
    :list_id,
    :notes
  ]

  use ExConstructor
end
