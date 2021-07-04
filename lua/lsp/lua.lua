local bin = require("lspcontainers").command "sumneko_lua"
local lsp_config = require "lsp"

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.window = capabilities.window or {}
capabilities.window.workDoneProgress = true

local runtime_path = vim.split(package.path, ";")

table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local libraries = { [vim.fn.expand "$VIMRUNTIME/lua"] = true, [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true }

libraries = vim.tbl_extend("error", libraries, vim.api.nvim_get_runtime_file("", true))

require("lspconfig").sumneko_lua.setup {
  cmd = bin,
  on_attach = lsp_config.common_on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = runtime_path,
      },
      completion = {
        callSnippet = "Both",
      },
      diagnostics = {
        globals = { "vim" },
      },
      hint = {
        enable = true
      },
      workspace = {
        library = libraries,
        maxPreload = 10000,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

require("nlua.lsp.nvim").setup(require "lspconfig", {
  cmd = bin,
  globals = { "Color", "c", "Group", "g", "s" },
})
