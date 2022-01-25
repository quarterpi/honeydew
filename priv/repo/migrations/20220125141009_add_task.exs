defmodule Honeydew.Repo.Migrations.AddTask do
  use Ecto.Migration

  def change do
    create table(:please_tasks, primary_key: false) do
      add :task_id, :string, primary_key: true
      add :list_id, :string
      add :name, :string
      add :notes, :string
      add :status, :string

      timestamps()
    end

  end
end
