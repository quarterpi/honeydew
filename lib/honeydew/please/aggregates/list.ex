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

  def apply(%List{} = list, %ListAdded{} = event) do
    %List{
      list
      | list_id: event.list_id,
        name: event.name,
        notes: event.notes,
        status: :active
    }
  end
end
