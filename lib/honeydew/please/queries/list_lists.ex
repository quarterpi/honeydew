defmodule Honeydew.Please.Queries.ListLists do
  use Cqrs.Query

  alias Honeydew.Please.Projections.List

  field :status, :enum, values: List.statuses()

  binding :list, List
end
