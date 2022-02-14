defmodule Honeydew.Please.Commands.CompleteList do
  @moduledoc """
  Command to mark list as completed.
  """

  use Cqrs.Command
  use Cqrs.Command.EventDerivation

  field :list_id, :string
  field :notes, :string

  derive_event Honeydew.Please.Events.ListCompleted do
    @moduledoc """
    Event that signals a list was completed.
    """
  end
end
