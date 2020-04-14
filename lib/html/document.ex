defmodule Html.Document do
  @enforce_keys [:children]
  defstruct @enforce_keys

  def new(children), do: %Html.Document{children: children}
end
