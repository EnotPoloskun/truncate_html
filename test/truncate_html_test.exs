defmodule TruncateHtmlTest do
  use ExUnit.Case

  test "truncate without word break" do
    assert TruncateHtml.truncate_html("<div>Test1 Test2</div>", 4) == "<div>Test1...</div>"
  end

  test "truncate with word break" do
    assert TruncateHtml.truncate_html("<div>Test1 Test2</div>", 4, break_word: true) == "<div>Test...</div>"
  end

  test "truncate with custom omission" do
    assert TruncateHtml.truncate_html("<div>Test1 Test2</div>", 4, omission: "...to be continued") == "<div>Test1...to be continued</div>"
  end

  test "truncate between multiple tags" do
    assert TruncateHtml.truncate_html("<div class='test'><ul><li data-test='test'>Test1 Test2</li></ul></div>", 4) == "<div class='test'><ul><li data-test='test'>Test1...</li></ul></div>"
  end

  test "truncate with script tag" do
    assert TruncateHtml.truncate_html("<div>Test<script>Test</script>Test2 Test3</div>", 5) == "<div>Test<script>Test</script>Test2...</div>"
  end
end
