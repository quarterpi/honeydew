defmodule Honeydew.Please.Commands.AddList do
  @moduledoc """
  Command to add a new list.
  """

  defstruct [
    :list_id,
    :name,
    :notes
  ]

  use ExConstructor
end
