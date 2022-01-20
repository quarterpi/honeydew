defmodule Honeydew.PleaseTest do
  use Honeydew.DataCase

  alias Honeydew.Please

  describe "lists" do
    alias Honeydew.Please.List

    import Honeydew.PleaseFixtures

    @invalid_attrs %{name: nil, notes: nil}

    test "list_lists/0 returns all lists" do
      list = list_fixture()
      assert Please.list_lists() == [list]
    end

    test "get_list!/1 returns the list with given id" do
      list = list_fixture()
      assert Please.get_list!(list.id) == list
    end

    test "create_list/1 with valid data creates a list" do
      valid_attrs = %{name: "some name", notes: "some notes"}

      assert {:ok, %List{} = list} = Please.create_list(valid_attrs)
      assert list.name == "some name"
      assert list.notes == "some notes"
    end

    test "create_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Please.create_list(@invalid_attrs)
    end

    test "update_list/2 with valid data updates the list" do
      list = list_fixture()
      update_attrs = %{name: "some updated name", notes: "some updated notes"}

      assert {:ok, %List{} = list} = Please.update_list(list, update_attrs)
      assert list.name == "some updated name"
      assert list.notes == "some updated notes"
    end

    test "update_list/2 with invalid data returns error changeset" do
      list = list_fixture()
      assert {:error, %Ecto.Changeset{}} = Please.update_list(list, @invalid_attrs)
      assert list == Please.get_list!(list.id)
    end

    test "delete_list/1 deletes the list" do
      list = list_fixture()
      assert {:ok, %List{}} = Please.delete_list(list)
      assert_raise Ecto.NoResultsError, fn -> Please.get_list!(list.id) end
    end

    test "change_list/1 returns a list changeset" do
      list = list_fixture()
      assert %Ecto.Changeset{} = Please.change_list(list)
    end
  end
end
