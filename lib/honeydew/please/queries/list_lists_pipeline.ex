defmodule Honeydew.Please.Queries.ListListsPipeline do
  use Blunt.QueryPipeline

  alias Blunt.Query
  alias Honeydew.Repo
  alias Honeydew.Please.Projections.List

  @impl true
  def create_query(filters, context) do
    preload = Query.preload(context)
    query = from l in List, as: :list, preload: ^preload

    Enum.reduce(filters, query, fn
      {:status, status}, query -> from [list: l] in query, where: l.status == ^status
    end)
  end

  @impl true
  def handle_dispatch(query, _context, opts) do
    Repo.all(query, opts)
  end
end
