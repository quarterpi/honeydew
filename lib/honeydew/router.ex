defmodule Honeydew.Router do
  @moduledoc """
  The Commanded Router.
  """

  use Commanded.Commands.Router

  alias Honeydew.Please.List
  alias Honeydew.Please.Commands.{
    AddList,
  }

  if Mix.env() == :dev do
    middleware(Commanded.Middleware.Logger)
  end

  identify(List, by: :list_id)

  dispatch(
    [
      AddList,
    ],
    to: List
  )


end
