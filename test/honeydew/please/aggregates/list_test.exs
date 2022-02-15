defmodule Honeydew.Please.ListTest do
  use ExUnit.Case, async: true

  alias Honeydew.Please.List
  alias Honeydew.Please.Events.ListMade
  alias Honeydew.Please.Commands.MakeList

  use Cqrs.Testing.ExMachina
  use Cqrs.Testing.AggregateCase, aggregate: List

  factory MakeList
  factory ListMade

  test "can't create a list twice" do
    list_made = build(:list_made)
    make_list = build(:make_list)

    assert %{error: {:error, :list_already_exists}} =
             execute_command([list_made], %{make_list | list_id: list_made.list_id})
  end
end
