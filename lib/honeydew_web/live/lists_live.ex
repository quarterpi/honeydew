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

  def mount(_params, _session, socket) do
    lists = Please.list_lists()
    socket = 
      socket
      |> Surface.init()
      |> assign(
        lists: lists,
      )
    {:ok, socket}
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
            <div class="list__item--discard">X</div>
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
        <Form for={:list} submit="add_list">
          <Field name="name" >
            <Label />
            <TextInput field="name" />
          </Field>
          <Field name="notes" >
            <Label />
            <TextInput field="notes" />
          </Field>
          <Submit label="Save" />
          <button class="button-cancel" :on-click="toggle_make" >Cancel</button>
        </Form>
      </div>
    </div>
    """
  end

  def handle_event("toggle_make", _, socket) do
    {:noreply, assign(socket, show_make?: !socket.assigns.show_make?)}
  end

  def handle_event("add_list", %{"list" => %{"name" => name, "notes" => notes }}, socket) do
    Please.make_list(name, notes)
    {:noreply, assign(socket, show_make?: false)}
  end

end
