defmodule Honeydew.Please.Events.TaskThwarted do
  @moduledoc """
  A Task was thwarted, meaning that it was not possible to complete.
  """

  @derive Jason.Encoder

  defstruct [
    :task_id,
    :notes
  ]
end
