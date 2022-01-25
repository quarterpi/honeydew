defmodule Honeydew.Please.Events.TaskAdded do
  @moduledoc """
  Event that indicates a task was added to a list.
  """

  @derive Jason.Encoder

  defstruct [
    :task_id,
    :list_id,
    :name,
    :notes
  ]
end
