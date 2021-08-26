if vim.g.loaded_go_ftplugin then
  return
end

vim.g.loaded_go_ftplugin = true

_G.MGo = {}

-- Code from https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-imports
function _G.MGo.goimports(timeout_ms)
  local context = { source = { organizeImports = true } }

  vim.validate { context = { context, "t", true } }

  local params = vim.lsp.util.make_range_params()

  params.context = context

  -- See the implementation of the textDocument/codeAction callback
  -- (lua/vim/lsp/handler.lua) for how to do this properly.
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)

  if not result or next(result) == nil then
    return
  end

  local actions = result[1].result

  if not actions then
    return
  end

  local action = actions[1]

  -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
  -- is a CodeAction, it can have either an edit, a command or both. Edits
  -- should be executed first.
  if action.edit or type(action.command) == "table" then
    if action.edit then
      vim.lsp.util.apply_workspace_edit(action.edit)
    end
    if type(action.command) == "table" then
      vim.lsp.buf.execute_command(action.command)
    end
  else
    vim.lsp.buf.execute_command(action)
  end
end

require"events".nvim_create_autocmd { "BufWritePre", "*.go", "call v:lua.MGo.goimports(1000)" }

local debug_install_dir = vim.fn.stdpath "data" .. "/dapinstall/go"

if vim.fn.glob(debug_install_dir) == "" then
  require("nvim-dap.install").install(
    "go debug",
    debug_install_dir,
    [[
    if ! command -v dlv > /dev/null 2>&1; then
      go get github.com/go-delve/delve/cmd/dlv
    fi

    git clone https://github.com/golang/vscode-go && cd vscode-go
    npm i
    npm run compile
  ]]
  )
end

local dap = require "dap"

dap.adapters.go = {
  type = "executable",
  command = "node",
  args = { vim.fn.stdpath "data" .. "/dapinstall/go/vscode-go/dist/debugAdapter.js" },
}

dap.configurations.go = {
  {
    type = "go",
    name = "Debug",
    request = "launch",
    showLog = false,
    program = "${file}",
    dlvToolPath = vim.fn.exepath "dlv", -- Adjust to where delve is installed
  },
}
