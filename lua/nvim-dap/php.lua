local debug_install_dir = vim.fn.stdpath("data") .. "/dapinstall/php/php-debug/"

if vim.fn.glob(debug_install_dir) == "" then
  require"nvim-dap.install".install("php debug", debug_install_dir, [[
    git clone https://github.com/xdebug/vscode-php-debug php-debug --depth 1 --recursive && cd php-debug
    npm i
    npm run build
  ]])
end

local dap = require("dap")

dap.adapters.php = {
  type = "executable",
  command = "node",
  args = { debug_install_dir .. "out/phpDebug.js" }
}

dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 9000
  }
}

