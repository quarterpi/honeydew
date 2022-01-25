defmodule Honeydew.Please.Task do
  @moduledoc """
  Aggregate for Tasks in Please context.
  """

  alias Honeydew.Please.Task
  alias Honeydew.Please.Commands.{
    AddTask,
    CompleteTask,
    ThwartTask,
  }
  alias Honeydew.Please.Events.{
    TaskAdded,
    TaskCompleted,
    TaskThwarted,
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

  def execute(%Task{} = task, %CompleteTask{task_id: task_id, notes: notes}) do
    cond do
      task.status == :active ->
        %TaskCompleted{
          task_id: task_id,
          notes: notes
        }
      task.status == :completed ->
        {:error, :task_already_completed}
      task.status == :thwarted ->
        {:error, :task_was_thwarted}
      task.status == :removed ->
        {:error, :task_was_removed}
      true ->
        {:error, :task_not_active}
    end
  end

  def execute(%Task{} = task, %ThwartTask{task_id: task_id, notes: notes}) do
    cond do
      task.status == :active ->
        %TaskThwarted{
          task_id: task_id,
          notes: notes
        }
      task.status == :completed ->
        {:error, :task_was_completed}
      task.status == :thwarted ->
        {:error, :task_already_thwarted}
      task.status == :removed ->
        {:error, :task_was_removed}
      true ->
        {:error, :task_not_active}
    end
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

  def apply(%Task{} = task, %TaskCompleted{} = event) do
    %Task{
      task
      | notes: event.notes,
      status: :completed
    }
  end

  def apply(%Task{} = task, %TaskThwarted{} = event) do
    %Task{
      task
      | notes: event.notes,
      status: :thwarted
    }
  end
end
