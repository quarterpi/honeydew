defmodule Honeydew.Please.Commands.RemoveTask do
  @moduledoc """
  Mercifully, attempt to remove a task.
  """

  use Cqrs.Command
  use Cqrs.Command.EventDerivation
  alias Honeydew.Please.Projections.Task

  field :task_id, :string
  field :notes, :string

  derive_event Honeydew.Please.Events.TaskRemoved do
    @moduledoc """
    Thankfully, the task was removed.
    """

    field :status, :enum, values: Task.statuses(), default: :removed
  end
end
