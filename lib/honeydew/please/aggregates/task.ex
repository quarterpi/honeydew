defmodule Honeydew.Please.Task do
  @moduledoc """
  Aggregate for Tasks in Please context.
  """

  alias Honeydew.Please.Task
  alias Honeydew.Please.Commands.{
    AddTask,
  }
  alias Honeydew.Please.Events.{
    TaskAdded
  }

  defstruct [
    :task_id,
    :list_id,
    :name,
    :notes,
    :status
  ]

  def execute(%Task{task_id: task_id}, %AddTask{} = command) when task_id == command.task_id, do: {:error, :task_already_exists}
  def execute(%Task{task_id: nil}, %AddTask{task_id: task_id, list_id: list_id, name: name, notes: notes}) do
    %TaskAdded{
      task_id: task_id,
      list_id: list_id,
      name: name,
      notes: notes
    }
  end

  def apply(%Task{} = task, %TaskAdded{} = event) do
    %Task{
      task
      | task_id: event.task_id,
      list_id: event.list_id,
      name: event.name,
      notes: event.notes,
      status: :active
    }
  end
end
