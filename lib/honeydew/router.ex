defmodule Honeydew.Router do
  @moduledoc """
  The Commanded Router.
  """

  use Commanded.Commands.Router

  alias Honeydew.Please.List
  alias Honeydew.Please.Task
  alias Honeydew.Please.Commands.{
    AddList,
    CompleteList,
    DiscardList,
    ReactivateList,
    AddTask,
    CompleteTask,
    ThwartTask,
  }

  if Mix.env() == :dev do
    middleware(Commanded.Middleware.Logger)
  end

  identify(List, by: :list_id)
  identify(Task, by: :task_id)

  dispatch(
    [
      AddList,
      CompleteList,
      DiscardList,
      ReactivateList,
    ],
    to: List
  )

  dispatch(
    [
      AddTask,
      CompleteTask,
      ThwartTask,
    ],
    to: Task
  )


end
