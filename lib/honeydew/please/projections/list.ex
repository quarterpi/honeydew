defmodule Honeydew.Please.Projections.List do
  @moduledoc """
  Projection for our List Aggregate. A projection "projects" the current
  state based on all events up until now.
  """

  use Ecto.Schema

  @primary_key {:list_id, :string, []}

  schema "please_list" do
    field :name, :string
    field :notes, :string
    field :status, :atom

    timestamps()
  end
end
