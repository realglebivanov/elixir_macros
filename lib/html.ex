defmodule Html do
  defmacro markup(do: block) do
    children =
      block
      |> Html.Ast.tags_to_macros
      |> Html.Ast.expressions

    quote do
      unquote(children) |> Html.Document.new
    end
  end

  defmacro tag(name, tag_attrs \\ [], block_attrs \\ []) do
    {block, attrs} = Keyword.pop(tag_attrs ++ block_attrs, :do)
    expressions = Html.Ast.expressions(block)
    quote bind_quoted: [name: name, attrs: attrs, expressions: expressions] do
      Html.Tag.new(name, attrs, expressions)
    end
  end

  defmacro text(do: text), do: quote do: %Html.Value{text: unquote(text)}
end
