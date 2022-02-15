defmodule Honeydew.Please.Commands.MakeList do
  @moduledoc """
  Command to make a new list.
  """

  use Cqrs.Command
  use Cqrs.Command.EventDerivation

  field :notes, :string
  field :name, :string

  internal_field :list_id, :string

  @impl true
  def after_validate(command) do
    %{command | list_id: Honeydew.CustomId.new()}
  end

  derive_event Honeydew.Please.Events.ListMade do
    @moduledoc """
    Event that signals a new list was made.
    """
  end
end
