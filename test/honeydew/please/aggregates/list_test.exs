defmodule Honeydew.Please.ListTest do
  use ExUnit.Case, async: true
  alias Honeydew.Please.List

  use Cqrs.Testing.ExMachina
  use Cqrs.Testing.AggregateCase, aggregate: List
end
