defmodule Html.Formatters.Raw do
  def as_string(%Html.Document{children: children}), do: as_string(children)
  def as_string(%Html.Value{text: text}), do: text
  def as_string(%Html.Tag{children: children} = tag) do
    Html.Formatters.Tag.open(tag)
    |> Kernel.<>(as_string(children))
    |> Kernel.<>(Html.Formatters.Tag.close(tag))
  end
  def as_string(content) when is_list(content) do
    Enum.reduce(content, "", &(&2 <> as_string(&1)))
  end
  def as_string(nil), do: ""
end
