defmodule Honeydew.Please.Events.ListReactivated do
  @moduledoc """
  Event indicating that a list has been reactivated after being discarded or completed.
  """

  @derive Jason.Encoder

  defstruct [
    :list_id,
    :notes
  ]
end
