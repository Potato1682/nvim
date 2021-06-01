local debug_install_dir = vim.fn.stdpath("data") .. "/dapinstall/python/"

if vim.fn.glob(debug_install_dir) == "" then
  require"nvim-dap.install".install("debugpy server", debug_install_dir, [[
    python -m venv debugpy
    debugpy/bin/python -m pip install debugpy
    debugpy/bin/python -m pip install pytest
  ]])
end

local dap = require("dap-python")

dap.setup(debug_install_dir .. "debugpy/bin/python")
dap.test_runner = "pytest"

