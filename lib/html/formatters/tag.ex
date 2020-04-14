defmodule Html.Formatters.Tag do
  def open(%Html.Tag{name: "doctype!"}), do: "<DOCTYPE!>"
  def open(%Html.Tag{name: name, attrs: []}), do: "<#{name}>"
  def open(%Html.Tag{name: name, attrs: attrs}) do
    "<"
    |> Kernel.<>(name)
    |> Kernel.<>(format_attrs(attrs))
    |> Kernel.<>(">")
  end

  def close(%Html.Tag{name: "doctype!"}), do: ""
  def close(%Html.Tag{name: name}), do: "</#{name}>"

  defp format_attrs(attrs) do
    Enum.reduce(attrs, "", &(&2 <> " #{elem(&1, 0)}=\"#{elem(&1, 1)}\""))
  end
end
