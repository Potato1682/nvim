# The template file

The template file allow you to save code which you need to write many times in your programming language.
You can automatically generate code by creating a template file according to this document.

## Creating a template file

The template file directory is in your nvim config directory.

- on Linux and Mac: `~/.config/nvim/template`
- on Windows: `%LocalAppData%\nvim\template`

Template selector is select the match, `template` as a free pattern and any other exact match.

#### Example
```
 ~/.config/nvim/template
 |-- docs
 |   `-- template.md
 |-- src
 |   `-- template.py
 |-- template.cs
 |-- template.rb
 |-- template.py
 |-- template_spec.rb
 `-- templateTest.cs
```

Template is loaded as following:

| Open file    | Template that is loaded |
| :----------- | :---------------------- |
| foo.py       | template.py             |
| src/foo.py   | src/template.py         |
| Foo.cs       | template.cs             |
| FooTest.cs   | templateTest.cs         |
| foo.rb       | template.rb             |
| foo_spec.rb  | template_spec.rb        |
| foo.md       | (None)                  |
| docs/foo.md  | docs/template.md        |

## Special Symbols

Template files has some special symbols.

- `<+CLASS NAME+>`: Filename without extensions.
- `<+CURSOR+>`: Initial cursor location.

