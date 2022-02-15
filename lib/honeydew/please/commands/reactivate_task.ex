defmodule Honeydew.Please.Commands.ReactivateTask do
  @moduledoc """
  UGH! Reactivate the task.
  """

  use Cqrs.Command
  use Cqrs.Command.EventDerivation

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
