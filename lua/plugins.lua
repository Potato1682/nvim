vim.g.loaded_tutor = 1
vim.g.loaded_spec = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_logipat = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_sql_completion = 1
vim.g.loaded_syntax_completion = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.vimsyn_embed = 1

local set = vim.api.nvim_set_var

set("dein#auto_recache", 1)

set("dein#lazy_rplugins", 1)
set("dein#types#git#clone_depth", 1)
set("dein#install_process_timeout", 300)
set("dein#install_progress_type", "tabline")
set("dein#install_message_type", "none")
set("dein#enable_name_conversion", 1)

if vim.fn.filereadable(vim.fn.stdpath "data" .. "/dein/token") == 1 then
  set("dein#install_github_api_token", vim.fn.readfile(vim.fn.stdpath "data" .. "/dein/token")[1])
end

local dein_directory = vim.fn.stdpath "data" .. "/dein"
local dein_repository = dein_directory .. "/repos/github.com/Shougo/dein.vim"

vim.opt.runtimepath = vim.opt.runtimepath ^ dein_repository

if vim.fn["dein#load_state"](dein_directory) == 1 then
  local dein_toml_directory = vim.fn.stdpath "config" .. "/dein"
  local dein_toml = dein_toml_directory .. "/base.toml"
  local dein_toml_lazy = dein_toml_directory .. "/lazy.toml"

  vim.fn["dein#begin"](dein_directory)

  vim.fn["dein#load_toml"](dein_toml, { lazy = 0 })
  vim.fn["dein#load_toml"](dein_toml_lazy, { lazy = 1 })

  vim.fn["dein#end"]()
  vim.fn["dein#save_state"]()
end

if vim.fn.has "vim_starting" ~= 0 and vim.fn["dein#check_install"] ~= 0 then
  vim.fn["dein#install"]()
  vim.fn["dein#remote_plugins"]()
end

local unused_plugins = vim.fn["dein#check_clean"]()

if vim.fn.len(unused_plugins) > 0 then
  vim.fn.map(unused_plugins, "delete(v:val, 'rf')")
  vim.fn["dein#recache_runtimepath"]()
end
