defmodule Html.Tag do
  def open(name, []), do: "<#{name}>"
  def open(name, attrs) do
    "<"
    |> Kernel.<>(name)
    |> Kernel.<>(attributes(attrs))
    |> Kernel.<>(">")
  end

  def close(name), do: "</#{name}>"

  defp attributes(attrs) do
    Enum.reduce(attrs, " ", &(&2 <> "#{elem(&1, 0)}=\"#{elem(&1, 1)}\""))
  end
end
