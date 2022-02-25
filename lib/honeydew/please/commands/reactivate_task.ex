defmodule Honeydew.Please.Commands.ReactivateTask do
  @moduledoc """
  UGH! Reactivate the task.
  """

  use Blunt.Command
  use Blunt.Command.EventDerivation

  alias Honeydew.Please.Projections.Task

  field :task_id, :string
  field :notes, :string

  derive_event Honeydew.Please.Events.TaskReactivated do
    @moduledoc """
    OH NO! WHYYYYYY!
    """
    field :status, :enum, values: Task.statuses(), default: :active
  end
end
