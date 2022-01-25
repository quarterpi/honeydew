defmodule Honeydew.Please.Events.TaskReactivated do
  @moduledoc """
  OH NO! WHYYYYYY!
  """

  @derive Jason.Encoder

  defstruct [
    :task_id,
    :notes
  ]
end
