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
  }
  alias Honeydew.Please.Projections.{
    List,
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

  def make_list(name, notes) do
    list = %MakeList{
      list_id: CustomId.new(),
      name: name,
      notes: notes
    }
    App.dispatch(list)
  end
end
