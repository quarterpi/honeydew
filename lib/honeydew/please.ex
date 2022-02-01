defmodule Honeydew.Please do
  @moduledoc """
  The Please context.
  """

  import Ecto.Query, warn: false
  alias Honeydew.Repo
  alias Honeydew.App
  alias Honeydew.Support.CustomId

  alias Honeydew.Please.Commands.{
    MakeList,
    DiscardList,
  }
  alias Honeydew.Please.Projections.{
    List,
  }
  alias Honeydew.Please.Queries.{
    ActiveLists,
  }

  @doc """
  Returns the list of lists.

  ## Examples

      iex> list_lists()
      [%List{}, ...]

  """
  def list_lists do
    Repo.all(List)
  end

  def list_active_lists do
    ActiveLists.new() |> Repo.all()
  end

  def make_list(name, notes) do
    list = %MakeList{
      list_id: CustomId.new(),
      name: name,
      notes: notes
    }
    App.dispatch(list)
  end

  def discard_list(list_id, notes) do
    discard = %DiscardList{
      list_id: list_id,
      notes: notes
    }

    App.dispatch(discard)
  end
end
