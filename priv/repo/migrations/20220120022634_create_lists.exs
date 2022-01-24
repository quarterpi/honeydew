defmodule Honeydew.Repo.Migrations.CreateLists do
  use Ecto.Migration

  def change do
    create table(:please_lists, primary_key: false) do
      add :list_id, :string, primary_key: true
      add :name, :string
      add :notes, :string
      add :status, :atom

      timestamps()
    end

  end
end
