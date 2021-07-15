local M = {}

local ns

local function has_eol()
  if not vim.opt_local.eol._value and (vim.opt_local.binary._value or not vim.opt_local.fixeol._value) then
    return false
  end

  return true
end

local function is_saved(bufnr)
  if vim.fn.getbufinfo(bufnr)[1].changed == 1 then
    return false
  end

  if vim.opt_local.buftype._value ~= "" then
    return false
  end

  if vim.fn.filereadable(vim.api.nvim_buf_get_name(bufnr)) == 1 then
    return true
  end

  return false
end

local function eol_at_eof(bufnr)
  if is_saved(bufnr) then
    return #vim.fn.readfile(vim.api.nvim_buf_get_name(bufnr), "b") ~= vim.fn.getbufinfo(bufnr)[1].linecount
  else
    return has_eol()
  end
end

function M.check(_)
  if vim.opt_local.buftype._value == "nofile" or vim.opt_local.buftype:get() == "prompt" then
    return false
  end

  local filetype = vim.opt_local.filetype._value

  for _, pattern in ipairs { "dashboard", "NvimTree", "neogit", "git.*", "undotree", "dapui.*", "vista.*", "dbui", "toggleterm" } do
    if filetype:match(pattern) then
      return false
    end
  end

  return true
end

function M.clean(bufnr)
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
end

function M.redraw(bufnr)
  local text = "[EOF]"
  local hl = "SpecialKey"

  if not eol_at_eof(bufnr) then
    text = "[EOF] "
    hl = "Error"
  end

  vim.api.nvim_buf_set_virtual_text(bufnr, ns, vim.fn.getbufinfo(bufnr)[1].linecount - 1, { { text, hl } }, {})
end

local function setup()
  ns = vim.api.nvim_create_namespace "eof"

  M.redraw(vim.fn.bufnr())

  local redraw_commands = string.format(
    "lua %s; if (vim.fn.getcmdwintype() == '' and (%s)) then %s end",
    "require'modules.eof'.clean(vim.fn.bufnr())",
    "require'modules.eof'.check(vim.fn.bufnr())",
    "require'modules.eof'.redraw(vim.fn.bufnr())"
  )

  require("events").nvim_create_augroups {
    eof = {
      { "TextChanged,TextChangedI,TextChangedP,BufWritePost,BufWinEnter", "*", redraw_commands },
      { "OptionSet", "endofline,fixendofline,binary", redraw_commands },
    },
  }

  vim.g.loaded_eof = true
end

if not vim.g.loaded_eof then
  setup()
end

return M
