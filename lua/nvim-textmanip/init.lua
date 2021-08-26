vim.g.textmanip_hooks = {}

function vim.g.textmanip_hooks.finish(tm)
  local helper = vim.fn["textmanip#helper#get"]()

  if tm.linewise then
    if vim.opt_local.filetype:get() == "html" then
      helper.indent(tm)
    end
  else
    helper.remove_trailing_WS(tm)
  end
end
