if vim.g.loaded_php_ftplugin then
  return
end

vim.g.loaded_php_ftplugin = true

local lsp_config = require "lsp"
local bin = vim.fn.stdpath "data" .. "/lspinstall/php/node_modules/.bin/intelephense"

if vim.fn.filereadable(bin) == 0 then
  require("lspinstall").install_server "php"
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

require("lspconfig").intelephense.setup {
  cmd = { bin, "--stdio" },
  on_attach = lsp_config.common_on_attach,
  capabilities = capabilities,
}

local debug_install_dir = vim.fn.stdpath "data" .. "/dapinstall/php/php-debug/"

if vim.fn.glob(debug_install_dir) == "" then
  require("nvim-dap.install").install(
    "php debug",
    debug_install_dir,
    [[
    git clone https://github.com/xdebug/vscode-php-debug php-debug --depth 1 --recursive && cd php-debug
    npm i
    npm run build
  ]]
  )
end

local dap = require "dap"

dap.adapters.php = {
  type = "executable",
  command = "node",
  args = { debug_install_dir .. "out/phpDebug.js" },
}

dap.configurations.php = {
  {
    type = "php",
    request = "launch",
    name = "Listen for Xdebug",
    port = 9000,
  },
}
