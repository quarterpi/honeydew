defmodule Honeydew.Please.Commands.MakeList do
  @moduledoc """
  Command to make a new list.
  """

  defstruct [
    :list_id,
    :name,
    :notes
  ]

  use ExConstructor
end
