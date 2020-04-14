defprotocol Html.Formatters.Formatter do
  @fallback_to_any false

  def as_string(formatter, document)
end

defimpl Html.Formatters.Formatter, for: Html.Document do
  def as_string(%Html.Document{} = document, :pretty) do
    Html.Formatters.Pretty.as_string(document)
  end
  def as_string(%Html.Document{} = document, :raw) do
    Html.Formatters.Raw.as_string(document)
  end
end
