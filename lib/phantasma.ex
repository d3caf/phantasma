defmodule Phantasma do
  @moduledoc """
  Phantasma keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  @spec tap(any, (any -> any)) :: any
  @doc """
  Calls `func/1` on a value, pipes the result to `IO.inspect/2`, and then returns the original value. Similar to `Kernel.tap/2` except auto-inspects the result of the function.
  """
  def tap(value, func) do
    func.(value) |> IO.inspect(limit: :infinity)

    value
  end
end
