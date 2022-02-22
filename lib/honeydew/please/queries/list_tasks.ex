defmodule Honeydew.Please.Queries.ListTasks do
  @moduledoc """
  Returns a list of tasks that match the given filters
  """
  use Cqrs.Query

  alias Honeydew.Please.Projections.Task

  field :list_id, :string, required: true

  binding :task, Task
end
