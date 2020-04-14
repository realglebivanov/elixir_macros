defmodule Html.Tag do
  @enforce_keys [:name, :attrs, :children]
  defstruct @enforce_keys

  def new(name, attrs, children) do
    %Html.Tag{name: name, attrs: attrs, children: children}
  end
end
