defmodule Honeydew.Router do
  @moduledoc """
  The Commanded Router.
  """

  use Commanded.Commands.Router

  if Mix.env() == :dev do
    middleware(Commanded.Middleware.Logger)
  end


end
