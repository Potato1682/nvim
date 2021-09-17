vim.g.textmanip_hooks = {}

function _G.textmanip_hook(tm)
  local helper = vim.fn["textmanip#helper#get"]()

  if tm.linewise then
    if vim.tbl_contains({ "html", "xml", "xaml" }, vim.opt_local.filetype:get()) then
      helper.indent(tm)
    end
  else
    helper.remove_trailing_WS(tm)
  end
end

vim.g.textmanip_hooks.finish = _G.textmanip_hook

