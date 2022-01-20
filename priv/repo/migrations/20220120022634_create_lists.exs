defmodule Honeydew.Repo.Migrations.CreateLists do
  use Ecto.Migration

  def change do
    create table(:lists) do
      add :name, :string
      add :notes, :string

      timestamps()
    end
  end
end
