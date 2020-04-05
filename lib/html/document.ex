defmodule Html.Document do
  def concat(block) when is_binary(block), do: block
  def concat(blocks) when is_list(blocks) do
    Enum.reduce(blocks, "", &concat(&2, &1))
  end

  defp concat(nil, nil), do: ""
  defp concat(s1, nil), do: s1
  defp concat(nil, s2), do: s2
  defp concat(s1, s2) when is_binary(s1) and is_binary(s2), do: s1 <> s2
  defp concat(s1, s2) when is_binary(s1) and is_list(s2), do: s1 <> concat(s2)
  defp concat(s1, s2) when is_list(s1) and is_binary(s2), do: concat(s1) <> s2
  defp concat(s1, s2) when is_list(s1) and is_list(s2), do: concat(s1 ++ s2)
end
