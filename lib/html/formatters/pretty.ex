defmodule Html.Formatters.Pretty do
  @padding_unit "  "
  @newline "\n"

  def as_string(%Html.Document{children: children}), do: as_string(children, "")
  def as_string(%Html.Tag{} = tag), do: as_string(tag, @padding_unit)

  defp as_string(nil, _padding), do: ""
  defp as_string(%Html.Value{text: text}, padding) do
    @newline <> padding <> text
  end
  defp as_string(%Html.Tag{children: children} = tag, padding) do
    @newline
    <> padding
    <> Html.Formatters.Tag.open(tag)
    <> as_string(children, padding <> @padding_unit)
    <> @newline <> padding
    <> Html.Formatters.Tag.close(tag)
  end

  defp as_string(content, padding) when is_list(content) do
    Enum.reduce(content, "", fn block, document ->
      document
      <> @newline
      <> padding
      <> as_string(block, padding <> @padding_unit)
    end)
  end
end
