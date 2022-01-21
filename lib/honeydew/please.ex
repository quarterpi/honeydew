defmodule Honeydew.Please do
  @moduledoc """
  The Please context.
  """

  import Ecto.Query, warn: false
  alias Honeydew.Repo

  alias Honeydew.Please.List

  @doc """
  Returns the list of lists.

  ## Examples

      iex> list_lists()
      [%List{}, ...]

  """
  def list_lists do
    Repo.all(List)
  end
end
