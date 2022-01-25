defmodule Honeydew.Please.Events.TaskCompleted do
  @moduledoc """
  Yay, the task is complete!
  """

  @derive Jason.Encoder

  defstruct [
    :task_id,
    :notes
  ]
end
