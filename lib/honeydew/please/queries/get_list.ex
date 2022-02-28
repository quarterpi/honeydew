defmodule Honeydew.Please.Queries.GetList do
  @moduledoc """
  Gets a single list
  """
  use Blunt.Query
  alias Honeydew.Please.Projections.List

  field :list_id, :string, required: true

  binding :list, List
end
