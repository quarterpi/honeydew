defmodule Honeydew.PleaseFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Honeydew.Please` context.
  """

  @doc """
  Generate a list.
  """
  def list_fixture(attrs \\ %{}) do
    {:ok, list} =
      attrs
      |> Enum.into(%{
        name: "some name",
        notes: "some notes"
      })
      |> Honeydew.Please.create_list()

    list
  end
end
