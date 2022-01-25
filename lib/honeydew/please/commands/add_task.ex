defmodule Honeydew.Please.Commands.AddTask do
  @moduledoc """
  Add a task.
  """

  defstruct [
    :task_id,
    :list_id,
    :name,
    :notes,
  ]

  use ExConstructor
end
