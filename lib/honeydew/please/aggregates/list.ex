defmodule Honeydew.Please.List do
  use Cqrs.Ddd

  @moduledoc """
  List Aggregate in Please Context.
  """

  alias Honeydew.Please.Projections.List
  alias Honeydew.Please.Commands.{MakeList, CompleteList, DiscardList, ReactivateList}

  aggregate_state do
    field :list_id, :string
    field :status, :enum, values: List.statuses()
  end

  def execute(%{list_id: nil}, %MakeList{} = command),
    do: MakeList.list_made(command)

  def execute(_state, %MakeList{}),
    do: {:error, :list_already_exists}

  def execute(%{status: :active}, %CompleteList{} = command),
    do: CompleteList.list_completed(command)

  def execute(%{status: status}, %CompleteList{}) do
    case status do
      :discarded -> {:error, :list_discarded}
      :completed -> {:error, :list_already_completed}
      _ -> {:error, :list_not_active}
    end
  end

  def execute(%{status: :active}, %DiscardList{} = command),
    do: DiscardList.list_discarded(command)

  def execute(%{status: status}, %DiscardList{}) do
    case status do
      :discarded -> {:error, :list_already_discarded}
      :completed -> {:error, :list_completed}
      _ -> {:error, :list_not_active}
    end
  end

  def execute(%{status: :active}, %ReactivateList{}),
    do: {:error, :list_already_active}

  def execute(_state, %ReactivateList{} = command),
    do: ReactivateList.list_reactivated(command)

  alias Honeydew.Please.Events.{ListMade, ListCompleted, ListDiscarded, ListReactivated}

  def apply(state, %ListMade{} = event) do
    values = Map.take(event, [:list_id, :status])
    update(state, values)
  end

  def apply(state, %ListCompleted{}) do
    put_status(state, :completed)
  end

  def apply(%{} = state, %ListDiscarded{}) do
    put_status(state, :discarded)
  end

  def apply(%{} = state, %ListReactivated{}) do
    put_status(state, :active)
  end
end
