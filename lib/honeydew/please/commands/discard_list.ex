defmodule Honeydew.Please.Commands.DiscardList do
  @moduledoc """
  Command to mark list as discarded.
  """

  use Cqrs.Command
  use Cqrs.Command.EventDerivation

  field :list_id, :string
  field :notes, :string

  derive_event Honeydew.Please.Events.ListDiscarded do
    @moduledoc """
    Event that signals a list was discarded.
    """
  end
end
