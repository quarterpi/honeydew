defmodule Honeydew.Please.Projectors.List do
  @moduledoc """
  Projector for List read model.
  """
  use Commanded.Projections.Ecto,
    application: Honeydew.App,
    name: "please_list_projection",
    repo: Honeydew.Repo

  alias Honeydew.Please.Events.{
    ListMade,
    ListCompleted,
    ListDiscarded,
    ListReactivated,
  }
  alias Honeydew.Please.Projections.List
  alias HoneydewWeb.Endpoint
  
  project %ListMade{list_id: list_id, name: name, notes: notes}, fn multi ->
    Ecto.Multi.insert(multi, :please_list, %List{
      list_id: list_id,
      name: name,
      notes: notes,
      status: "active"
    })
  end

  project %ListCompleted{list_id: list_id, notes: notes}, fn multi ->
    update_list(multi, list_id,
      set: [
        notes: notes,
        status: "completed"
      ]
    )
  end

  project %ListDiscarded{list_id: list_id, notes: notes}, fn multi ->
    update_list(multi, list_id,
      set: [
        notes: notes,
        status: "discarded"
      ]
    )
  end

  project %ListReactivated{list_id: list_id, notes: notes}, fn multi ->
    update_list(multi, list_id,
      set: [
        notes: notes,
        status: "active"
      ]
    )
  end

  def after_update(%ListMade{} = event, _metadata, _changes) do
    list = 
      %List{
        list_id: event.list_id,
        name: event.name,
        notes: event.notes,
        status: "active"
      }

    list
    |> broadcast("list_made")
    :ok
  end

  def after_update(%ListDiscarded{} = event, _metadata, _changes) do
    list = 
      %List{
        list_id: event.list_id,
        notes: event.notes,
        status: "discarded"
      }

    list
    |> broadcast("list_discarded")
    :ok
  end

  defp update_list(multi, list_id, updates) do
    Ecto.Multi.update_all(multi, :please_list, list_query(list_id), updates)
  end

  defp list_query(list_id) do
    from(l in List, where: l.list_id == ^list_id)
  end

  defp broadcast(%List{} = list, event) do
    Endpoint.broadcast("lists", event, list.list_id)
  end
end
