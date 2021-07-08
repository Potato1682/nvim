local set = vim.api.nvim_set_var

set("dein#auto_recache", 1)

set("dein#lazy_rplugins", 1)
set("dein#enable_notification", 1)
set("dein#install_max_processes", 64)
set("dein#install_message_type", "none")
set("dein#enable_name_conversion", 1)

if vim.fn.filereadable(vim.fn.stdpath "data" .. "/dein/token") == 1 then
  set("dein#install_github_api_token", vim.fn.readfile(vim.fn.stdpath "data" .. "/dein/token")[1])
end

local dein_directory = vim.fn.stdpath "data" .. "/dein"
local dein_repository = dein_directory .. "/repos/github.com/Shougo/dein.vim"

vim.opt.runtimepath = dein_repository .. "," .. vim.opt.runtimepath._value

if vim.call("dein#load_state", dein_directory) == 1 then
  local dein_toml_directory = vim.fn.stdpath "config" .. "/dein"
  local dein_toml = dein_toml_directory .. "/base.toml"
  local dein_toml_lazy = dein_toml_directory .. "/lazy.toml"

  vim.fn["dein#begin"](dein_directory)

  vim.fn["dein#load_toml"](dein_toml, { lazy = 0 })
  vim.fn["dein#load_toml"](dein_toml_lazy, { lazy = 1 })

  vim.fn["dein#end"]()
  vim.fn["dein#save_state"]()
end

if vim.fn["dein#check_install"] ~= 0 then
  vim.fn["dein#install"]()
  vim.fn["dein#remote_plugins"]()
end

local unused_plugins = vim.fn["dein#check_clean"]()

if vim.fn.len(unused_plugins) > 0 then
  vim.fn.map(unused_plugins, "delete(v:val, 'rf')")
end
