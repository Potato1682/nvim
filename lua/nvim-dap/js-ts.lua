local debug_install_dir = vim.fn.stdpath("data") .. "/dapinstall/nodejs/"

if vim.fn.glob(debug_install_dir .. "node-debug") == "" then
  require"nvim-dap.install".install("node debug server", debug_install_dir, [[
    git clone https://github.com/microsoft/vscode-node-debug2 node-debug --depth 1 --recursive && cd node-debug
    npm i
    npx gulp build
  ]])
end

local dap = require("dap")

dap.adapters.node2 = { type = 'executable', command = 'node', args = { debug_install_dir .. 'node-debug/out/src/nodeDebug.js' } }

dap.configurations.javascript = {
  {
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal'
  }
}

