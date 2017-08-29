defmodule TruncateHtml.HtmlToken do
  @unpaired_tags ["br", "hr", "img"]

  def is_html_tag(token) do
    String.match?(token, ~r/<\/?[^>]+>/) && !is_html_comment(token)
  end

  def is_html_comment(token) do
    String.match?(token, ~r/<\s?!--.*-->/)
  end

  def is_open_tag(token) do
    String.match?(token, ~r/<(?!(?:script|\/))[^>]+>/i)
  end

  def matching_close_tag(token) do
    case String.match?(token, ~r/<(#{Enum.join(@unpaired_tags, "|")})[^>]*>/i) do
      true -> ""
      false -> "</#{Regex.named_captures(~r/<(?<tag>\w+)\s?.*>/, token)["tag"]}>"
    end
  end

  def token_spec(token) do
    case is_html_tag(token) do
      true -> {:tag, is_open_tag(token)}
      false ->
        case is_html_comment(token) do
          true -> {:comment}
          false -> {:text}
        end
    end
  end
end
