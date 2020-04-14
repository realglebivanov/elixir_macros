defmodule Html.Ast do
  @tags MapSet.new([
    :doctype!, :div, :hr, :html, :body, :head, :title, :p, :pre, :span, :h1,
  ])

  def tags_to_macros(ast) do
    Macro.prewalk(ast, fn
      {tag, ctx, args} = node ->
        if tag in @tags, do: {:tag, ctx, [to_string(tag) | args]}, else: node

      node -> node
    end)
  end

  def expressions({:__block__, _ctx, expressions}), do: List.wrap(expressions)
  def expressions(expression), do: expression
end
