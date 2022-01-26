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

  defp update_list(multi, list_id, updates) do
    Ecto.Multi.update_all(multi, :please_list, list_query(list_id), updates)
  end

  defp list_query(list_id) do
    from(l in List, where: l.list_id == ^list_id)
  end
end
