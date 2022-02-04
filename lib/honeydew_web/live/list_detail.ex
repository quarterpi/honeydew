defmodule HoneydewWeb.ListsLive.Detail do
  @moduledoc"""
  Where the work in a list gets done.
  """

  use HoneydewWeb, :surface_live_view

  alias Honeydew.Please

  alias Surface.Components.Form

  data current_list, :string, default: ""
  data tasks, :list, default: []

  def mount(%{"list_id" => list_id}, _session, socket) do
    tasks = Please.get_tasks_in_list(list_id)
    socket = 
      socket
      |> Surface.init()
      |> assign(current_list: list_id)
      |> assign(tasks: tasks)
    {:ok, socket}
  end

  def render(assigns) do
    ~F"""
    <div class="list-detail">
      <button :on-click="show_add_task">Add Task</button>
      {#for t <- @tasks}
        <hr />
        <div class="task" >
          <h3>{t.name}</h3>
          <h5>{t.notes}</h5>
          <button :on-click="complete_task" phx-value-id={t.task_id}>Complete Task</button>
          <button :on-click="thwart_task" phx-value-id={t.task_id}>Thwart Task</button>
          <button :on-click="remove_task" phx-value-id={t.task_id}>Remove Task</button>
          <button :on-click="reactivate_task" phx-value-id={t.task_id}>Reactivate Task</button>
        </div>
      {/for}
    </div>
    """
  end

  def handle_event("show_add_task", _, socket) do
    Please.add_task("Buy Milk", "Why are we always out of milk?", socket.assigns.current_list)
    {:noreply, socket}
  end

  def handle_event("complete_task", %{"id" => task_id}, socket) do
    Please.complete_task(task_id, "completed as requested")
    {:noreply, socket}
  end

  def handle_event("thwart_task", %{"id" => task_id}, socket) do
    Please.thwart_task(task_id, "it's just not possible")
    {:noreply, socket}
  end

  def handle_event("remove_task", %{"id" => task_id}, socket) do
    Please.remove_task(task_id, "no longer needed")
    {:noreply, socket}
  end

  def handle_event("reactivate_task", %{"id" => task_id}, socket) do
    Please.reactivate_task(task_id, "I want it back")
    {:noreply, socket}
  end
end
