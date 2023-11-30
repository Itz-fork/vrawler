# Vrawler
Some helper functions that I use to scrape websites

### Retrive by selectors
Used to retrive html elements using css selectors

- Function: `from_selector`
- Arguments:
    - `hdoc`: html document as a string (if parsed convert to str with `parsed.str()`)
    - `selectors`: string of css selectors (Ex: `#myid > p > a:nth-child(1)`)

<details>
    <summary>Example</summary>
    
```html
<html lang="en">
<head>
    <title>Test file</title>
</head>
<body>
    <div id="mydiv">
        <a href="https://www.google.com/">Google</a>
        <a href="https://vlang.io/"><span>V</span> lang</a>
    </div>
</body>
</html>
```

```v
import vrawler

fn main() {
    // Suppose this index.html == above html
    html_str := read_file('/home/scraped/mysite/index.html')
    spn := vrawler.from_selector(html_str, '#mydiv > a:nth-child(2) > span')
    println(spn)
}

// stdout
// [<span>V</span>]
```

</details>
