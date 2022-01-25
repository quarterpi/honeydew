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

end
