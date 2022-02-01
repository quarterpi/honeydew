defmodule HoneydewWeb.ListsLive do
  @moduledoc """
  Render a users lists.
  """
  use HoneydewWeb, :surface_live_view

  alias Honeydew.Please

  alias Surface.Components.Link.Button
  alias Surface.Components.Form
  alias Surface.Components.Form.{
    Field,
    Label,
    TextInput,
    Submit,
  }

  data lists, :list, default: []
  data show_make?, :boolean, default: false
  @topic "lists"

  def mount(_params, _session, socket) do
    lists = Please.list_active_lists()
    HoneydewWeb.Endpoint.subscribe(@topic)
    socket = 
      socket
      |> Surface.init()
      |> assign(
        lists: lists,
      )
    {:ok, socket}
  end

  def handle_info(%{event: "list_made"}, socket) do
    IO.inspect(socket)
    lists = Please.list_active_lists()

    socket = 
      socket
      |> assign(lists: lists)

    {:noreply, socket}
  end

  def handle_info(%{event: "list_discarded", payload: list_id}, socket) do
    lists = Please.list_active_lists()

    socket = 
      socket
      |> assign(lists: lists)
    {:noreply, socket}
  end

  def render(assigns) do
    ~F"""
    <div class="list-container">
      <div class="list__item list__item--add">
        <div class="list__item--header">
          <div class="list__item--spacer">
          </div>
        </div>
        <div class="list__item--body list__item--make" :on-click="toggle_make">
          <h3>Add A List</h3>
        </div>
      </div>
      {#if @lists}
        {#for l <- @lists}
        <div class="list__item" id={l.list_id}>
          <div class="list__item--header">
            <div class="list__item--discard" :on-click="discard_list" phx-value-id={l.list_id}>X</div>
          </div>
          <div class="list__item--body">
            <h3 class="list__item--name">{l.name}</h3>
            <h6 class="list__item--notes">{l.notes}</h6>
          </div>
        </div>
        {/for}
      {/if}
    </div>
    <div class={"make__list", "make__list--visible": @show_make?, "make__list--hidden": !@show_make?}>
      <div class="form__container">
        <Form for={:list} submit="make_list">
          <Field name="name" >
            <Label />
            <TextInput field="name" />
          </Field>
          <Field name="notes" >
            <Label />
            <TextInput field="notes" />
          </Field>
          <Submit label="Save" />
          <button class="button-cancel" type="button" :on-click="toggle_make" >Cancel</button>
        </Form>
      </div>
    </div>
    """
  end

  def handle_event("toggle_make", _, socket) do
    {:noreply, assign(socket, show_make?: !socket.assigns.show_make?)}
  end

  def handle_event("make_list", %{"list" => %{"name" => name, "notes" => notes }}, socket) do
    Please.make_list(name, notes)
    {:noreply, assign(socket, show_make?: false)}
  end

  def handle_event("discard_list", %{"id" => list_id}, socket) do
    Please.discard_list(list_id, "")
    {:noreply, socket}
  end

end
