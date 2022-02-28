defmodule Honeydew.PleaseTest do
  use HoneydewWeb.ChannelCase

  alias Honeydew.Please
  alias Honeydew.Please.Commands

  # Setup convenience factories
  use Blunt.Testing.ExMachina

  # This replaces please_fixtures
  # you can call
  #   * build(:create_list) to create a MakeList command struct
  #   * dispatch(:create_list) to create and dispatch a MakeList command
  factory Commands.MakeList, as: :create_list

  describe "lists" do
    setup do
      HoneydewWeb.Endpoint.subscribe("lists")
    end

    @invalid_attrs %{name: nil, notes: nil}
    test "create_list/1 with valid data creates a list" do
      assert {:ok, _} = Please.create_list(name: "some name", notes: "some notes")

      # Since you don't dispatch strongly or return any events,
      # we have to wait for the broacast
      assert_broadcast "list_made", list_id, 1000

      assert {:ok, %{name: "some name", notes: "some notes"}} = Please.get_list(list_id: list_id)
    end

    test "list_lists/0 returns all lists" do
      assert {:ok, _} = dispatch(:create_list)
      assert_broadcast "list_made", list_id, 1000
      assert {:ok, [%{list_id: ^list_id}]} = Please.list_lists()
    end

    # test "get_list!/1 returns the list with given id" do
    #   list = nil
    #   assert Please.get_list!(list.id) == list
    # end

    # test "create_list/1 with valid data creates a list" do
    #   valid_attrs = %{name: "some name", notes: "some notes"}

    #   assert {:ok, %List{} = list} = Please.make_list(valid_attrs)
    #   assert list.name == "some name"
    #   assert list.notes == "some notes"
    # end

    # test "create_list/1 with invalid data returns error changeset" do
    #   assert {:error, %Ecto.Changeset{}} = Please.create_list(@invalid_attrs)
    # end

    # test "update_list/2 with valid data updates the list" do
    #   list = nil
    #   update_attrs = %{name: "some updated name", notes: "some updated notes"}

    #   assert {:ok, %List{} = list} = Please.update_list(list, update_attrs)
    #   assert list.name == "some updated name"
    #   assert list.notes == "some updated notes"
    # end

    # test "update_list/2 with invalid data returns error changeset" do
    #   list = nil
    #   assert {:error, %Ecto.Changeset{}} = Please.update_list(list, @invalid_attrs)
    #   assert list == Please.get_list!(list.id)
    # end

    # test "delete_list/1 deletes the list" do
    #   list = nil
    #   assert {:ok, %List{}} = Please.delete_list(list)
    #   assert_raise Ecto.NoResultsError, fn -> Please.get_list!(list.id) end
    # end

    # test "change_list/1 returns a list changeset" do
    #   list = nil
    #   assert %Ecto.Changeset{} = Please.change_list(list)
    # end
  end
end
