defmodule Html do
  defmacro markup(do: block) do
    Html.Ast.tags_to_macros(block)
  end

  defmacro tag(name, attrs \\ []) do
    {block, attrs} = Keyword.pop(attrs, :do)
    quote bind_quoted:
            [name: name, attrs: attrs, block: block],
          do: tag(name, attrs, do: block)
  end

  defmacro tag(name, attrs, do: block) do
    expressions = Html.Ast.expressions(block)
    quote bind_quoted: [name: name, attrs: attrs, expressions: expressions] do
      Html.Tag.open(name, attrs)
      |> Kernel.<>(Html.Document.concat(expressions))
      |> Kernel.<>(Html.Tag.close(name))
    end
  end

  defmacro text(do: text), do: text
end
