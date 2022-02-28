defmodule Honeydew.Please.Commands.CompleteTask do
  @moduledoc """
  Mark task as completed.
  """

  use Blunt.Command
  use Blunt.Command.EventDerivation

  alias Honeydew.Please.Projections.Task

  field :task_id, :string
  field :notes, :string

  derive_event Honeydew.Please.Events.TaskCompleted do
    @moduledoc """
    Yay, the task is complete!
    """

    field :status, :enum, values: Task.statuses(), default: :completed
  end
end
