# Vrawler
Some helper functions that I use to scrape websites

## Get element by css selectors
```html
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test file</title>
</head>
<body>
    <div>
        <div>
            <a href="https://www.google.com/">Google</a>
            <a href="https://vlang.io/"><span>V</span> lang</a>
        </div>
    </div>
</body>
</html>
```

To select `span` elemet,
```v
above_html_as_str := '<html>...</html>'
x := element_from_selectors(above_html_as_str, "div > a:nth-child(2) > span")
println(x)

// Out
// [<span>V</span>]
```

If the html has more multiple `span` tags in side the `a` tag, it'll return a list of elements (`[]&Tag`)

```v
// Out
// [<span>V</span>, <span>Another V</span>]
```