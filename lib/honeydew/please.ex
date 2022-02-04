defmodule Honeydew.Please do
  @moduledoc """
  The Please context.
  """

  import Ecto.Query, warn: false
  alias Honeydew.Repo
  alias Honeydew.App
  alias Honeydew.Support.CustomId

  alias Honeydew.Please.Commands.{
    MakeList,
    DiscardList,
    AddTask,
    CompleteTask,
    ThwartTask,
    RemoveTask,
    ReactivateTask
  }
  alias Honeydew.Please.Projections.{
    List,
    Task
  }
  alias Honeydew.Please.Queries.{
    ActiveLists,
    TasksFromList,
  }

  @doc """
  Returns the list of lists.

  ## Examples

      iex> list_lists()
      [%List{}, ...]

  """
  def list_lists do
    Repo.all(List)
  end

  def list_active_lists do
    ActiveLists.new() |> Repo.all()
  end

  def make_list(name, notes) do
    list = %MakeList{
      list_id: CustomId.new(),
      name: name,
      notes: notes
    }
    App.dispatch(list)
  end

  def discard_list(list_id, notes) do
    discard = %DiscardList{
      list_id: list_id,
      notes: notes
    }

    App.dispatch(discard)
  end

  def add_task(name, notes, list_id) do
    task = %AddTask{
      task_id: CustomId.new(),
      list_id: list_id,
      name: name,
      notes: notes
    }
    App.dispatch(task)
  end

  def complete_task(task_id, notes) do
    complete = %CompleteTask{
      task_id: task_id,
      notes: notes
    }

    App.dispatch(complete)
  end

  def thwart_task(task_id, notes) do
    thwart = %ThwartTask{
      task_id: task_id,
      notes: notes
    }

    App.dispatch(thwart)
  end

  def remove_task(task_id, notes) do
    remove = %RemoveTask{
      task_id: task_id,
      notes: notes
    }

    App.dispatch(remove)
  end

  def reactivate_task(task_id, notes) do
    reactivate = %ReactivateTask{
      task_id: task_id,
      notes: notes
    }

    App.dispatch(reactivate)
  end

  def list_tasks() do
    Repo.all(Task)
  end

  def get_tasks_in_list(list_id) do
    TasksFromList.new(list_id) |> Repo.all()
  end
end
