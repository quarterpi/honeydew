defmodule Honeydew.Please.List do
  @moduledoc """
  List Aggregate in Please Context.
  """

  alias Honeydew.Please.List
  alias Honeydew.Please.Commands.{
    AddList,
    CompleteList,
    DiscardList,
    ReactivateList,
  }
  alias Honeydew.Please.Events.{
    ListAdded,
    ListCompleted,
    ListDiscarded,
    ListReactivated,
  }

  defstruct [
    :list_id,
    :name,
    :notes,
    :status,
  ]
  
  def execute(%List{list_id: list_id}, %AddList{list_id: id}) when list_id == id, do: {:error, :list_already_exists}
  def execute(%List{list_id: nil}, %AddList{list_id: list_id, name: name, notes: notes}) do
    %ListAdded{
      list_id: list_id,
      name: name,
      notes: notes
    }
  end

  def execute(%List{} = list, %CompleteList{list_id: list_id, notes: notes}) do
    cond do
      list.status == :active ->
        %ListCompleted{
          list_id: list_id,
          notes: notes
        }
      list.status == :discarded ->
        {:error, :list_discarded}
      list.status == :completed ->
        {:error, :list_already_completed}
      true ->
        {:error, :list_not_active}
    end
  end

  def execute(%List{} = list, %DiscardList{list_id: list_id, notes: notes}) do
    cond do
      list.status == :active ->
        %ListDiscarded{
          list_id: list_id,
          notes: notes
        }
      list.status == :completed ->
        {:error, :list_completed}
      list.status == :discarded ->
        {:error, :list_already_discarded}
      true ->
        {:error, :list_not_active}
    end
  end

  def execute(%List{} = list, %ReactivateList{list_id: list_id, notes: notes}) do
    cond do
      list.status == :active ->
        {:error, :list_already_active}
      true ->
        %ListReactivated{
          list_id: list_id,
          notes: notes
        }
    end
  end

  def apply(%List{} = list, %ListAdded{} = event) do
    %List{
      list
      | list_id: event.list_id,
        name: event.name,
        notes: event.notes,
        status: :active
    }
  end

  def apply(%List{} = list, %ListCompleted{} = event) do
    %List{
      list
      | status: :completed,
      notes: event.notes
    }
  end

  def apply(%List{} = list, %ListDiscarded{} = event) do
    %List{
      list
      | status: :discarded,
      notes: event.notes
    }
  end

  def apply(%List{} = list, %ListReactivated{} = event) do
    %List{
      list
      | status: :active,
      notes: event.notes
    }
  end
end
