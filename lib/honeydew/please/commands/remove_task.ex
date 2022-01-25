defmodule Honeydew.Please.Commands.RemoveTask do
  @moduledoc """
  Mercifully, attempt to remove a task.
  """

  defstruct [
    :task_id,
    :notes
  ]

  use ExConstructor
end
