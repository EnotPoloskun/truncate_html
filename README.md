# TruncateHtml

Smart html truncate functionality. 

Sometimes you need to show user a part of a large html code. For example, you would like to show part of article as a preview. This package will help you to solve this problem. With the help of it you should not care of opening and closing tags to keep html structure correct.

## Installation

This package can be installed by adding `truncate_html` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:truncate_html, "~> 0.1.0"}
  ]
end
```

## How to use.

For example, you have a `html` 
```html
  <div class='content'>
    <div class='first-block'>
      First Second Third Fourth
    </div>
  </div>
```
and you need only first 10 symbols(e.g. as preview). 
```elixir
  TruncateHtml.truncate_html(html, truncate: 10)
```
The result of code above is
```html
"<div class='content'><div class='first-block'>First Second...</div></div>"
```

By default it doesn't break words and uses `...` as omission.

You can change this behavior by specifying `break_word` and `omissions` arguments into function. For example
```elixir
  TruncateHtml.truncate_html(html, truncate: 10, break_word: true, omision: "...to be continued")
```
will return
```html
"<div class='content'><div class='first-block'>First Seco...to be continued</div></div>"
```

Please, also notice, that it ignores all next line chars `\n` and counts multiple spaces in a row as one space.
