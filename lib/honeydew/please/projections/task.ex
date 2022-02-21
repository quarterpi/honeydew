defmodule Honeydew.Please.Projections.Task do
  @moduledoc """
  Read Model Projection for Task in Please context.
  """

  use Ecto.Schema

  @primary_key {:task_id, :string, []}

  @statuses [:active, :discarded, :completed, :thrwarted, :removed]
  @doc false
  def statuses, do: @statuses

  schema "please_tasks" do
    field :list_id, :string
    field :name, :string
    field :notes, :string
    field :status, Ecto.Enum, values: @statuses

    timestamps()
  end
end
