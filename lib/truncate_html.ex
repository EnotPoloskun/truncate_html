defmodule TruncateHtml do
  import TruncateHtml.HtmlToken

  @regex ~r/(?:<script.*>.*<\/script>)+|<\/?[^>]+>|[[:alpha:]0-9\|`~!@#\$%^&*\(\)\-_\+=\[\]{}:;'²³§",\.\/?]+|\s+|[[:punct:]]/

  def truncate_html(html, limit, opts \\ []) do
    omission = opts[:omission] || "..."
    break_word = opts[:break_word] || false

    Regex.scan(@regex, html)
    |> List.flatten
    |> Enum.map(&(String.replace(&1, ~r/\n|(\s+)/, " ")))
    |> process_tokens([], "", 0, limit, omission, break_word)
  end

  defp process_tokens([token | rest], open_tags, result, length, limit, omission, break_word) when length < limit do
    case token_spec(token) do
      {:tag, true} ->
        process_tokens(rest, [token] ++ open_tags, result <> token, length, limit, omission, break_word)
      {:tag, false} ->
        process_tokens(rest, without_open_tag(open_tags, token), result <> token, length, limit, omission, break_word)
      {:text} ->
        process_tokens(rest, open_tags, result <> token, length + String.length(token), limit, omission, break_word)
      {:comment} ->
        process_tokens(rest, open_tags, result <> token, length, limit, omission, break_word)
    end
  end

  defp process_tokens(_, open_tags, result, length, limit, omission, break_word) when length >= limit do
    case break_word do
      true ->
        String.slice(result, 0..(String.length(result) - (length - limit) - 1))
      false -> result
    end <> omission
    |> with_closed_tags(open_tags)
  end

  defp process_tokens([], _, result, _, _, _, _) do
    result
  end

  defp with_closed_tags(html, [tag | rest]) do
    with_closed_tags(html <> matching_close_tag(tag), rest)
  end

  defp with_closed_tags(html, []) do
    html
  end

  defp without_open_tag(tags, close_tag) do
    List.delete(tags, Enum.find(tags, &(matching_close_tag(&1) == close_tag)))
  end
end
