CONFIG_PATH = vim.fn.stdpath('config')
DATA_PATH = vim.fn.stdpath('data')
CACHE_PATH = vim.fn.stdpath('cache')

O = {
  author = "", -- REQUIRED
  japanese = false,
  auto_close_tree = 0,
  colorscheme = 'edge',
  -- @usage can be 'aura', 'neon'
  edge_style = 'neon',
  wrap_lines = false,
  number = true,
  relative_number = false,
  timeoutlen = 500,
  shell = "zsh",
  explorer = { disable_netrw = 0 },
  redmine = { site = "", api_key = "" },
  python = {
    -- @usage can be 'unittest', 'pytest'
    test_type = "pytest"
  }
}

