cache = true
codes = true
ranges = true

jobs = 4

exclude_files = {
  "template/",
  "lua/lsp/json/schemas.lua"
}

ignore = {
  "631"
}

files["lua/modules/buffer/init.lua"].ignore = {
  "311"
}

globals = {
  "O",
  "vim"
}

