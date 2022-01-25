defmodule Honeydew.Please.Projections.Task do
  @moduledoc """
  Read Model Projection for Task in Please context.
  """

  use Ecto.Schema

  @primary_key {:task_id, :string, []}

  schema "please_tasks" do
    field :list_id, :string
    field :name, :string
    field :notes, :string
    field :status, :string

    timestamps()
  end
end
