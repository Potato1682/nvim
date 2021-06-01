local bin = vim.fn.stdpath("data") .. "/lspinstall/lua/sumneko-lua-language-server"
local server = vim.fn.stdpath("data") .. "/lspinstall/lua/sumneko-lua/extension/server/"
local lsp_config = require("lsp")

if vim.fn.filereadable(bin) == 0 then require("lspinstall").install_server("lua") end

require'lspconfig'.sumneko_lua.setup {
  cmd = { bin },
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
      diagnostics = { globals = { 'vim' } },
      workspace = { library = { [vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true }, maxPreload = 10000 }
    }
  },
  on_attach = lsp_config.common_on_attach
}

local os = ""
local ext = ""

if vim.fn.has('win64') == 1 or vim.fn.has('win32') == 1 or vim.fn.has('win16') == 1 then
  os = "WINDOWS"
  ext = ".exe"
else
  os = vim.fn.toupper(vim.fn.substitute(vim.fn.system("uname"), '\n', '', ''))
end

local os_table = { WINDOWS = "Windows", CYGWIN = "Windows", MINGW = "Windows", LINUX = "Linux", DARWIN = "macOS" }

os = os_table[os]

require('nlua.lsp.nvim').setup(require('lspconfig'), {
  cmd = { server .. "bin/" .. os .. "/lua-language-server" .. ext, "-E", server .. "main.lua" },
  globals = { "Color", "c", "Group", "g", "s" }
})

