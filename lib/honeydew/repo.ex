defmodule Honeydew.Repo do
  use Ecto.Repo,
    otp_app: :honeydew,
    adapter: Ecto.Adapters.Postgres
end
