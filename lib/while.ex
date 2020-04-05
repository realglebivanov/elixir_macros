defmodule While do
  defmacro while(condition, do: block) do
    quote do
      [nil]
      |> Stream.cycle()
      |> Stream.take_while(fn _ -> unquote(condition) end)
      |> Stream.map(fn _ -> unquote(block) end)
      |> Stream.take_while(fn result -> result != :break end)
      |> Stream.run()
    end
  end
end
