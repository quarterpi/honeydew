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

  defp update_task(multi, task_id, updates) do
    Ecto.Multi.update_all(multi, :please_task, task_query(task_id), updates)
  end

  defp task_query(task_id) do
    from(t in Task, where: t.task_id == ^task_id)
  end

end
