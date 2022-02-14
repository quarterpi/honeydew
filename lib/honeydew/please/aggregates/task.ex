defmodule Honeydew.Please.Task do
  use Cqrs.Ddd

  @moduledoc """
  Aggregate for Tasks in Please context.
  """

  alias Honeydew.Please.Task

  alias Honeydew.Please.Commands.{
    AddTask,
    CompleteTask,
    ThwartTask,
    RemoveTask,
    ReactivateTask
  }

  alias Honeydew.Please.Events.{
    TaskAdded,
    TaskCompleted,
    TaskThwarted,
    TaskRemoved,
    TaskReactivated
  }

  alias Honeydew.Please.Projections.Task

  aggregate_state do
    field :task_id, :string
    field :status, :enum, values: Task.statuses()
  end

  def execute(%{task_id: nil}, %AddTask{} = command),
    do: AddTask.task_added(command)

  def execute(_state, %AddTask{}),
    do: {:error, :task_already_exists}

  def execute(%{status: :active}, %CompleteTask{} = command),
    do: CompleteTask.task_completed(command)

  def execute(%{status: status}, %CompleteTask{}) do
    case status do
      :completed -> {:error, :task_already_completed}
      :thwarted -> {:error, :task_was_thwarted}
      :removed -> {:error, :task_was_removed}
      _ -> {:error, :task_not_active}
    end
  end

  def execute(%{status: :active}, %ThwartTask{} = command),
    do: ThwartTask.task_thwarted(command)

  def execute(%{status: status}, %ThwartTask{}) do
    case status do
      :completed -> {:error, :task_was_completed}
      :thwarted -> {:error, :task_already_thwarted}
      :removed -> {:error, :task_was_removed}
      true -> {:error, :task_not_active}
    end
  end

  def execute(%{status: status}, %RemoveTask{} = command) do
    case status do
      :removed -> {:error, :task_was_removed}
      _ -> RemoveTask.task_removed(command)
    end
  end

  def execute(%{status: status}, %ReactivateTask{} = command) do
    case status do
      :active -> {:error, :task_already_active}
      _ -> ReactivateTask.task_reactivated(command)
    end
  end

  def apply(state, %TaskAdded{} = event) do
    values = Map.take(event, [:task_id, :status])
    update(state, values)
  end

  def apply(state, %TaskCompleted{status: status}),
    do: put_status(state, status)

  def apply(state, %TaskThwarted{status: status}),
    do: put_status(state, status)

  def apply(state, %TaskRemoved{status: status}),
    do: put_status(state, status)

  def apply(state, %TaskReactivated{status: status}),
    do: put_status(state, status)
end
