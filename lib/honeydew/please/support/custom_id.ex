defmodule Honeydew.CustomId do
  @current_version "1"

  @moduledoc """
  Compact, database friendly ids
  """

  def new() do
    @current_version <>
      (:erlang.system_time(:nanosecond)
       |> Base62.encode()) <>
      (:crypto.strong_rand_bytes(8) |> :binary.decode_unsigned() |> Base62.encode())
  end
end
