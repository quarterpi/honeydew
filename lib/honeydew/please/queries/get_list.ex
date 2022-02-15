defmodule Honeydew.Please.Queries.GetList do
  use Cqrs.Query
  alias Honeydew.Please.Projections.List

  field :list_id, :string, required: true

  binding :list, List
end
