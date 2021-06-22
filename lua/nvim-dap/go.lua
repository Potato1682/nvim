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
