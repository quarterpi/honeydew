defmodule Honeydew.Please.List do
  @moduledoc """
  List Aggregate in Please Context.
  """

  alias Honeydew.Please.List
  alias Honeydew.Please.Commands.{
    AddList,
    CompleteList,
  }
  alias Honeydew.Please.Events.{
    ListAdded,
    ListCompleted,
  }

  defstruct [
    :list_id,
    :name,
    :notes,
    :status,
  ]
  
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
end
