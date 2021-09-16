if vim.g.loaded_python_ftplugin then
  return
end

vim.g.loaded_python_ftplugin = true

local debug_install_dir = vim.fn.stdpath "data" .. "/dapinstall/python/"

if not vim.tbl_isempty(vim.loop.fs_stat(debug_install_dir) or {}) then
  require("nvim-dap.install").install(
    "debugpy",
    debug_install_dir,
    [[
    python -m venv debugpy
    debugpy/bin/python -m pip install debugpy
    debugpy/bin/python -m pip install pytest
  ]]
  )
end

local ok, dap_python = pcall(require, "dap-python")

if not ok then
  return
end

dap_python.setup(debug_install_dir .. "debugpy/bin/python")
dap_python.test_runner = O.python.test_type
