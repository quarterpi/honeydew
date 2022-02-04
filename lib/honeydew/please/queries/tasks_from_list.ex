defmodule Honeydew.Please.Queries.TasksFromList do
  @mdouledoc false

  import Ecto.Query

  alias Honeydew.Please.Projections.Task

  def new(list_id) do
    from(t in Task,
      where: t.list_id == ^list_id and t.status != "removed"
    )
  end
end
