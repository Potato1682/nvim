require "nvim-globals"
require "settings"

if require "first-load"() then
  require "plugins"

  return
end

require "nvim-dashboard"

require "plugins"

require "nvim-bufferline"
require "nvim-galaxyline"

require "keys"
require "providers"
require "commands"
require "events"
require "nvim-undotree"

require "nvim-dap"

require "lsp"
require "lsp.c-cpp"
require "nvim-dap.lua"
require "lsp.lua"
require "lsp.bash"
require "nvim-dap.js-ts"
require "lsp.js-ts"
require "lsp.json"
require "nvim-dap.python"
require "lsp.python"
require "lsp.yaml"
require "lsp.vim"
require "lsp.docker"
require "lsp.html"
require "lsp.emmet"
require "lsp.css"
require "lsp.tailwindcss"
require "lsp.vue"
require "nvim-dap.c-cpp-rust"
require "lsp.rust"
require "lsp.graphql"
require "nvim-dap.ruby"
require "lsp.ruby"
require "nvim-dap.go"
require "lsp.go"
require "nvim-dap.php"
require "lsp.php"
require "lsp.terraform"
require "lsp.svelte"
require "lsp.virtual-text"
