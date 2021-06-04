# The colorizer template file

The colorizer files allow you to specify new rules for displaying colors in signs.  
Those files are written in json format, you can write them as follows:
```json
{
  "colour_table": {
		"name1": "#ffffff",
		"name2": "#000fff"
	}
}
```

`name` is a partial match in the lines.  
This file can apply by restart your Neovim.

