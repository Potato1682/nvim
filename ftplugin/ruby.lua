if vim.g.loaded_ruby_ftplugin then
  return
end

vim.g.loaded_ruby_ftplugin = true

local debug_install_dir = vim.fn.stdpath "data" .. "/dapinstall/ruby/"

if vim.tbl_isempty(vim.loop.fs_stat(debug_install_dir) or {}) then
  require("nvim-dap.install").install(
    "ruby debug",
    debug_install_dir,
    [[
      bundle init

      echo >> Gemfile <<< '
      source "rubygems"
      gem "readapt"
      '

      bundle
    ]]
  )
end

local dap = require "dap"

dap.adapters.ruby = {
  type = "executable",
  command = "bundle",
  args = { "exec", "readapt", "stdio" },
  options = {
    cwd = debug_install_dir,
  },
}

dap.configurations.ruby = {
  {
    type = "ruby",
    request = "launch",
    name = "Rails",
    program = "bundle",
    programArgs = { "exec", "rails", "s" },
    useBundler = true,
  },
}
