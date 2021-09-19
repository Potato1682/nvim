cache = true
codes = true
ranges = true

jobs = 4

exclude_files = {
  "template/",
  "lua/lsp/json/schemas.lua",
  "plugin/packer_compiled.lua"
}

files["lua/modules/buffer/init.lua"].ignore = {
  "311/next"
}

files["lua/lush_theme/amethyst.lua"].ignore = {
  "113"
}

globals = {
  "O",
  "vim",
  "data_dir",
  "config_dir",
  "CURRENT_VENV"
}

