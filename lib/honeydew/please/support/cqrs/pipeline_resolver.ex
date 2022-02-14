defmodule Honeydew.Cqrs.PipelineResolver do
  @behaviour Cqrs.DispatchStrategy.PipelineResolver

  def resolve(:command, _message_module) do
    {:ok, Honeydew.Cqrs.CommandPipeline}
  end

  def resolve(:query, module) do
    {:ok, String.to_existing_atom(to_string(module) <> "Pipeline")}
  rescue
    _ -> :error
  end
end
