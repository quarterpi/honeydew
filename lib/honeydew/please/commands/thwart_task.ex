defmodule Honeydew.Please.Commands.ThwartTask do
  @moduledoc """
  Command that indicates a task is not possible to complete.
  """

  defstruct [
    :task_id,
    :notes
  ]

  use ExConstructor
end
