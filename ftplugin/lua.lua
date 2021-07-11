if vim.g.loaded_lua_ftplugin then
  return
end

vim.g.loaded_lua_ftplugin = true

local bin = require("lspcontainers").command "sumneko_lua"
local lsp_config = require "lsp"

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

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
        enable = true,
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

local dap = require "dap"

dap.configurations.lua = {
  {
    type = "nlua",
    request = "attach",
    name = "Attach to running Neovim instance",
    host = function()
      local value = vim.fn.input "Host [127.0.0.1]: "
      if value ~= "" then
        return value
      end
      return "127.0.0.1"
    end,
    port = function()
      local val = tonumber(vim.fn.input "Port: ")
      assert(val, "Please provide a port number")
      return val
    end,
  },
}

dap.adapters.nlua = function(callback, config)
  callback {
    type = "server",
    host = config.host,
    port = config.port,
  }
end
