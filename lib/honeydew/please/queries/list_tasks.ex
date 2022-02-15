defmodule Honeydew.Please.Queries.ListTasks do
  use Cqrs.Query

  alias Honeydew.Please.Projections.Task

  field :list_id, :string, required: true

  binding :task, Task
end
