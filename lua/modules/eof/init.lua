local M = {}

local ns

local function has_eol()
  if not vim.opt_local.eol:get() and (vim.opt_local.binary:get() or not vim.opt_local.fixeol:get()) then
    return false
  end

  return true
end

local function is_saved(bufnr)
  if vim.fn.getbufinfo(bufnr)[1].changed == 1 then
    return false
  end

  if vim.opt_local.buftype:get() ~= "" then
    return false
  end

  if vim.fn.filereadable(vim.api.nvim_buf_get_name(bufnr)) == 1 then
    return true
  end

  return false
end

local function eol_at_eof(bufnr)
  if is_saved(bufnr) then
    return #vim.fn.readfile(vim.api.nvim_buf_get_name(bufnr), "b") ~= vim.api.nvim_buf_line_count(bufnr)
  else
    return has_eol()
  end
end

function M.check(_)
  if vim.tbl_contains({ "nofile", "terminal", "prompt" }, vim.opt_local.buftype:get()) then
    return false
  end

  local filetype = vim.opt_local.filetype:get()

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
    text = "[EOF] " .. require("nvim-nonicons").get "x"
    hl = "ErrorMsg"
  end

  vim.api.nvim_buf_set_virtual_text(bufnr, ns, vim.fn.getbufinfo(bufnr)[1].linecount - 1, { { text, hl } }, {})
end

local function setup()
  ns = vim.api.nvim_create_namespace "eof"

  M.redraw(vim.api.nvim_get_current_buf())

  local redraw_commands = string.format(
    "lua %s; if (vim.fn.getcmdwintype() == '' and (%s)) then %s end",
    "require'modules.eof'.clean(vim.api.nvim_get_current_buf())",
    "require'modules.eof'.check(vim.api.nvim_get_current_buf())",
    "require'modules.eof'.redraw(vim.api.nvim_get_current_buf())"
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
