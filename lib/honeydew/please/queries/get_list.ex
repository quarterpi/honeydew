defmodule Honeydew.Please.Queries.GetList do
  @moduledoc """
  Gets a single list
  """
  use Cqrs.Query
  alias Honeydew.Please.Projections.List

  field :list_id, :string, required: true

  binding :list, List
end
