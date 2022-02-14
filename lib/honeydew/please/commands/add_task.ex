defmodule Honeydew.Please.Commands.AddTask do
  @moduledoc """
  Add a task.
  """

  use Cqrs.Command
  use Cqrs.Command.EventDerivation

  alias Honeydew.Please.Projections.Task

  field :list_id, :string
  field :name, :string
  field :notes, :string

  internal_field :task_id, :string

  @impl true
  def after_validate(command) do
    %{command | list_id: Honeydew.CustomId.new()}
  end

  derive_event Honeydew.Please.Events.TaskAdded do
    @moduledoc """
    Event that indicates a task was added to a list.
    """
    field :status, :enum, values: Task.statuses(), default: :active
  end
end
