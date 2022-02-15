defmodule Honeydew.Please.Commands.MakeListTest do
  use Honeydew.DataCase
  alias Honeydew.Please.Commands.MakeList

  test "name and notes required" do
    assert {:error, %{name: ["can't be blank"], notes: ["can't be blank"]}} = MakeList.new(%{})
  end

  test "list_id is always generated" do
    assert {:ok, %{list_id: list_id}, _discarded_data} = MakeList.new(name: "chris", notes: "hi")
    refute is_nil(list_id)
  end
end
