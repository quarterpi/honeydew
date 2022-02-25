defmodule Honeydew.Please.Queries.ListLists do
  @moduledoc """
  Returns a list of lists that match the given filters
  """
  use Blunt.Query

  alias Honeydew.Please.Projections.List

  field :status, :enum, values: List.statuses()

  binding :list, List
end
