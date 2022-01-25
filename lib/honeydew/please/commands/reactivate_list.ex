defmodule Honeydew.Please.Commands.ReactivateList do
  @moduledoc """
  Command to set list as active after being discarded or completed.
  """

  defstruct [
    :list_id,
    :notes
  ]

  use ExConstructor
end
