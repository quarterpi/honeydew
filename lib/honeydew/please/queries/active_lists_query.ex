defmodule Honeydew.Please.Queries.ActiveLists do
  @moduledoc """
  A query to return only the active lists.
  """

  import Ecto.Query

  alias Honeydew.Please.Projections.List

  def new() do
    from(l in List,
      where: l.status == "active"
    )
  end

end
