defmodule Honeydew.Please.Commands.CompleteList do
  @moduledoc """
  Command to mark list as completed.
  """

  defstruct [
    :list_id,
    :notes
  ]

  use ExConstructor
end
