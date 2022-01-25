defmodule Honeydew.Please.Commands.CompleteTask do
  @moduledoc """
  Mark task as completed.
  """

  defstruct [
    :task_id,
    :notes
  ]

  use ExConstructor
end
