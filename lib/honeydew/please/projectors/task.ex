defmodule Honeydew.Please.Projectors.Task do
  @moduledoc """
  Projector for Task read model.
  """

  use Commanded.Projections.Ecto,
    application: Honeydew.App,
    name: "please_task_projection",
    repo: Honeydew.Repo

  alias Honeydew.Please.Events.{
    TaskAdded,
    TaskCompleted,
    TaskThwarted,
    TaskRemoved,
    TaskReactivated,
  }
  alias Honeydew.Please.Projections.Task
  alias HoneydewWeb.Endpoint

  project %TaskAdded{task_id: task_id, list_id: list_id, name: name, notes: notes}, fn multi ->
    Ecto.Multi.insert(multi, :please_tasks, %Task{
      task_id: task_id,
      list_id: list_id,
      name: name,
      notes: notes,
      status: "active"
    })
  end

  project %TaskCompleted{task_id: task_id, notes: notes}, fn multi ->
    update_task(multi, task_id,
      set: [
        notes: notes,
        status: "completed"
      ]
    )
  end

  project %TaskThwarted{task_id: task_id, notes: notes}, fn multi ->
    update_task(multi, task_id,
      set: [
        notes: notes,
        status: "thwarted"
      ]
    )
  end

  project %TaskRemoved{task_id: task_id, notes: notes}, fn multi ->
    update_task(multi, task_id,
      set: [
        notes: notes,
        status: "removed"
      ]
    )
  end

  project %TaskReactivated{task_id: task_id, notes: notes}, fn multi ->
    update_task(multi, task_id,
      set: [
        notes: notes,
        status: "active"
      ]
    )
  end

  def after_update(%TaskAdded{} = event, _metadata, _changes) do
    task = 
      %Task{
        task_id: event.task_id,
        list_id: event.list_id,
        name: event.name,
        notes: event.notes,
        status: "active"
      }

    task 
    |> broadcast("task_added")
    :ok
  end

  def after_update(%TaskCompleted{} = event, _metadata, _changes) do
    task = 
      %Task{
        task_id: event.task_id,
        notes: event.notes,
        status: "completed"
      }

    task 
    |> broadcast("task_completed")
    :ok
  end

  def after_update(%TaskThwarted{} = event, _metadata, _changes) do
    task = 
      %Task{
        task_id: event.task_id,
        notes: event.notes,
        status: "thwarted"
      }

    task 
    |> broadcast("task_thwarted")
    :ok
  end

  def after_update(%TaskRemoved{} = event, _metadata, _changes) do
    task = 
      %Task{
        task_id: event.task_id,
        notes: event.notes,
        status: "removed"
      }

    task 
    |> broadcast("task_removed")
    :ok
  end

  def after_update(%TaskReactivated{} = event, _metadata, _changes) do
    task = 
      %Task{
        task_id: event.task_id,
        notes: event.notes,
        status: "removed"
      }

    task 
    |> broadcast("task_reactivated")
    :ok
  end

  defp update_task(multi, task_id, updates) do
    Ecto.Multi.update_all(multi, :please_task, task_query(task_id), updates)
  end

  defp task_query(task_id) do
    from(t in Task, where: t.task_id == ^task_id)
  end

  defp broadcast(%Task{} = task, event) do
    Endpoint.broadcast("task", event, task.task_id)
  end
end
