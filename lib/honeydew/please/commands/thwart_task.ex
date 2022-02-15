defmodule Honeydew.Please.Commands.ThwartTask do
  @moduledoc """
  Command that indicates a task is not possible to complete.
  """

  use Cqrs.Command
  use Cqrs.Command.EventDerivation

  alias Honeydew.Please.Projections.Task

  field :task_id, :string
  field :notes, :string

  derive_event Honeydew.Please.Events.TaskThwarted do
    @moduledoc """
    A Task was thwarted, meaning that it was not possible to complete.
    """
    field :status, :enum, values: Task.statuses(), default: :thrwarted
  end
end
