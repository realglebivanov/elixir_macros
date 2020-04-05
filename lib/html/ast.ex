defmodule Html.Ast do
  @tags [:div, :html, :p, :pre, :span, :h1]

  def tags_to_macros(ast) do
    Macro.prewalk(ast, fn
      {tag, ctx, args} when tag in @tags ->
        {:tag, ctx, [Atom.to_string(tag) | args]}

      node -> node
    end)
  end

  def expressions({:__block__, _ctx, expressions}), do: expressions
  def expressions(expression), do: expression
end
