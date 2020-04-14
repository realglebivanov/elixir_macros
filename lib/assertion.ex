defmodule Assertion do
  defmodule Specific do
    def assert(:==, x1, x2) when x1 == x2, do: :ok
    def assert(:==, x1, x2) do
      {:error, "Expected #{x1} to be equal to #{x2}"}
    end

    def assert(:<, x1, x2) when x1 < x2, do: :ok
    def assert(:<, x1, x2) do
      {:error, "Expected #{x1} to be less than #{x2}"}
    end
  end

  defmodule Runner do
    def run(module, tests) do
      tests
      |> Task.async_stream(&Kernel.apply(module, &1, []))
      |> Stream.map(&elem(&1, 1))
      |> Stream.map(fn
        :ok -> IO.write(".")
        {:error, message} -> IO.puts("\n#{message}\n")
      end)
      |> Stream.run()
    end
  end

  defmacro __using__(_opts) do
    quote do
      import unquote(__MODULE__)
      Module.register_attribute(__MODULE__, :tests, accumulate: true)
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def test_assertion(), do: Assertion.Runner.run(__MODULE__, @tests)
    end
  end

  defmacro test(name, do: block) do
    function_name = String.to_atom(name)

    quote do
      @tests unquote(function_name)
      def unquote(function_name)(), do: unquote(block)
    end
  end

  defmacro assert({op, _context, [arg1, arg2]}) do
    quote bind_quoted: [op: op, arg1: arg1, arg2: arg2] do
      Assertion.Specific.assert(op, arg1, arg2)
    end
  end
end
