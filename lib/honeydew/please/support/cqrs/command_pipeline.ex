defmodule Honeydew.Cqrs.CommandPipeline do
  @behaviour Cqrs.CommandPipeline
  alias Cqrs.DispatchContext, as: Context
  alias Commanded.Commands.ExecutionResult

  def handle_dispatch(command, context) do
    metadata = metadata(context)

    case Honeydew.App.dispatch(command, metadata: metadata) do
      {:ok, %ExecutionResult{} = result} ->
        response =
          result
          |> Map.from_struct()
          |> Map.drop([:metadata])

        Context.put_pipeline(context, :handle_dispatch, response)

      other ->
        Context.put_pipeline(context, :handle_dispatch, other)
    end
  end

  def metadata(context) do
    context
    |> Map.update!(:opts, &Enum.into(&1, %{}))
    |> Map.update!(:message, &Map.from_struct(&1))
    |> Map.take([:created_at, :message, :message_module, :message_type, :opts, :user])
  end
end
