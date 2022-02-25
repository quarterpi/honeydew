defmodule Honeydew.Please.Commands.ReactivateList do
  @moduledoc """
  Command to set list as active after being discarded or completed.
  """

  use Blunt.Command
  use Blunt.Command.EventDerivation

  field :list_id, :string
  field :notes, :string

  derive_event Honeydew.Please.Events.ListReactivated do
    @moduledoc """
       Event indicating that a list has been reactivated after being discarded or completed.
    """
  end
end
