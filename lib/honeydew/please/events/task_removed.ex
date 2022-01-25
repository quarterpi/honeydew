defmodule Honeydew.Please.Events.TaskRemoved do
  @moduledoc """
  Thankfully, the task was removed.
  """

  @derive Jason.Encoder

  defstruct [
    :task_id,
    :notes
  ]
end
