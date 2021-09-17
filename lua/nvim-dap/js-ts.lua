local debug_install_dir = data_dir .. "/dapinstall/javascript/"

local function debugger_exists(name)
  return vim.tbl_isempty(vim.loop.fs_stat(debug_install_dir .. name) or {})
end

if debugger_exists("node-debug") == "" then
  require("nvim-dap.install").install(
    "node debug server",
    debug_install_dir,
    [[
    git clone https://github.com/microsoft/vscode-node-debug2 node-debug --depth 1 --recursive && cd node-debug
    npm i
    npx gulp build
  ]]
  )
end

if debugger_exists("chrome-debug") == "" then
  require("nvim-dap.install").install(
    "debug in chrome",
    debug_install_dir,
    [[
      git clone https://github.com/microsoft/vscode-chrome-debug chrome-debug && cd chrome-debug
      npm i
      npm run build
    ]]
  )
end

if debugger_exists("firefox-debug") == "" then
  require("nvim-dap.install").install(
    "debug in firefox",
    debug_install_dir,
    [[
      git clone https://github.com/firefox-devtools/vscode-firefox-debug firefox-debug && cd firefox-debug
      npm i
      npm run build
    ]]
  )
end

local dap = require "dap"

dap.adapters.node2 = {
  type = "executable",
  command = "node",
  args = { debug_install_dir .. "node-debug/out/src/nodeDebug.js" },
}

dap.adapters.chrome = {
  type = "executable",
  command = "node",
  args = { debug_install_dir .. "chrome-debug/out/src/chromeDebug.js" },
}

dap.adapters.firefox = {
  type = "executable",
  command = "node",
  args = { debug_install_dir .. "firefox-debug/dist/adapter.bundle.js" },
}

dap.configurations.javascript = {
  {
    type = "node2",
    request = "launch",
    program = "${file}",
    cwd = vim.loop.cwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
}

dap.configurations.javascriptreact = {
  {
    type = "chrome",
    request = "attach",
    program = "${file}",
    cwd = vim.loop.cwd(),
    sourceMaps = true,
    protocol = "inspector",
    port = 9222,
    webRoot = "${workspaceFolder}",
  },
  {
    type = "firefox",
    request = "launch",
    file = "${file}",
    cwd = vim.loop.cwd(),
    port = 9222,
  },
}

dap.configurations.typescriptreact = {
  {
    type = "chrome",
    request = "attach",
    program = "${file}",
    cwd = vim.loop.cwd(),
    sourceMaps = true,
    protocol = "inspector",
    port = 9222,
    webRoot = "${workspaceFolder}",
  },
  {
    type = "firefox",
    request = "launch",
    file = "${file}",
    cwd = vim.loop.cwd(),
    port = 9222,
  },
}
