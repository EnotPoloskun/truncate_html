defmodule TruncateHtml.HtmlTokenTest do
  use ExUnit.Case

  test "is html tag" do
    assert TruncateHtml.HtmlToken.is_html_tag("<b>") == true
  end

  test "not html tag" do
    assert TruncateHtml.HtmlToken.is_html_tag("text") == false
  end

  test "is html comment" do
    assert TruncateHtml.HtmlToken.is_html_comment("<!-- comment -->") == true
  end

  test "not html comment" do
    assert TruncateHtml.HtmlToken.is_html_comment("<-- comment\ -->") == false
  end

  test "is open tag" do
    assert TruncateHtml.HtmlToken.is_open_tag("<div>") == true
    assert TruncateHtml.HtmlToken.is_open_tag("<br/>") == true
  end

  test "not open tag" do
    assert TruncateHtml.HtmlToken.is_open_tag("</div>") == false
  end

  test "matching closing tag" do
    assert TruncateHtml.HtmlToken.matching_close_tag("<div>") == "</div>"
    assert TruncateHtml.HtmlToken.matching_close_tag("<br/>") == ""
  end

  test "text token spec" do
    assert TruncateHtml.HtmlToken.token_spec("text") == {:text}
  end

  test "comment token spec" do
    assert TruncateHtml.HtmlToken.token_spec("<!-- comment -->") == {:comment}
  end

  test "open tag token spec" do
    assert TruncateHtml.HtmlToken.token_spec("<b>") == {:tag, true}
  end

  test "close tag token spec" do
    assert TruncateHtml.HtmlToken.token_spec("</b>") == {:tag, false}
  end
end
