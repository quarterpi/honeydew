defmodule Honeydew.Please.Commands.ReactivateTask do
  @moduledoc """
  UGH! Reactivate the task.
  """

  defstruct [
    :task_id,
    :notes
  ]

  use ExConstructor
end
