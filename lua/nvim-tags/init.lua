if vim.fn.executable "ctags" then
  vim.g["loaded_gentags#gtags"] = 1
  vim.g["gen_tags#ctags_auto_gen"] = 1
else
  vim.g["loaded_gentags#ctags"] = 1
  vim.g["gen_tags#gtags_auto_gen"] = 1
end
