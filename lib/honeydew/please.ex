defmodule Honeydew.Please do
  use Blunt.Context

  @moduledoc """
  The Please Context
  """
  alias Honeydew.Please.Commands
  alias Honeydew.Please.Queries

  command Commands.MakeList, as: :create_list
  command Commands.DiscardList
  command Commands.AddTask
  command Commands.CompleteTask
  command Commands.ThwartTask
  command Commands.RemoveTask
  command Commands.ReactivateTask

  query Queries.GetList
  query Queries.ListLists
  query Queries.ListLists, as: :list_active_lists, field_values: [status: :active]
  query Queries.ListTasks
end
