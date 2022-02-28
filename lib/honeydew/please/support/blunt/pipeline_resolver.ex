defmodule Honeydew.Blunt.PipelineResolver do
  @moduledoc """
  Resolves commands to `Honeydew.Blunt.CommandPipeline`

  Resolves queries to a corresponding `Pipeline` module.

  example: `Honeydew.Please.Queries.GetListPipeline` is the pipeline module for `Honeydew.Please.Queries.GetList`
  """
  @behaviour Blunt.DispatchStrategy.PipelineResolver

  def resolve(:command, _message_module) do
    {:ok, Honeydew.Blunt.CommandPipeline}
  end

  def resolve(:query, module) do
    {:ok, String.to_existing_atom(to_string(module) <> "Pipeline")}
  rescue
    _ -> :error
  end
end
