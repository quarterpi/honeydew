defmodule Honeydew.Please.List do
  @moduledoc """
  List Aggregate in Please Context.
  """

  alias Honeydew.Please.List
  alias Honeydew.Please.Commands.{
    AddList,
  }
  alias Honeydew.Please.Events.{
    ListAdded,
  }

  defstruct [
    :list_id,
    :name,
    :notes
  ]
  
  def execute(%List{}, %AddList{}) do
  end

  def apply(%List{}, %ListAdded{}) do
  end
end
