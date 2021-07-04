local lsp_config = require "lsp"
local bin = vim.fn.stdpath "data" .. "/lspinstall/ruby/solargraph/bin/solargraph"

if vim.fn.filereadable(bin) == 0 then
  require("lspinstall").install_server "ruby"
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.window = capabilities.window or {}
capabilities.window.workDoneProgress = true

require("lspconfig").solargraph.setup {
  cmd = { bin, "stdio" },
  on_attach = lsp_config.common_on_attach,
  capabilities = capabilities,
}

local debug_install_dir = vim.fn.stdpath "data" .. "/dapinstall/ruby/"

if vim.fn.glob(debug_install_dir) == "" then
  require("nvim-dap.install").install(
    "ruby debug",
    debug_install_dir,
    [[
    bundle init
    echo >> Gemfile <<< '
    source "rubygems"
    gem "readapt"
    '
    bundle
  ]]
  )
end

local dap = require "dap"

dap.adapters.ruby = {
  type = "executable",
  command = "bundle",
  args = { "exec", "readapt", "stdio" },
  options = {
    cwd = debug_install_dir,
  },
}

dap.configurations.ruby = {
  {
    type = "ruby",
    request = "launch",
    name = "Rails",
    program = "bundle",
    programArgs = { "exec", "rails", "s" },
    useBundler = true,
  },
}
