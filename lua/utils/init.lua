local M = {}

function M.define_command(name, action, option)
  local option_string = ""

  if option.bang then
    option_string = " -bang"
  end

  if option.buffer then
    option_string = option_string .. " -buffer"
  end

  vim.cmd("command!" .. option_string .. " " .. name .. " " .. action)
end

function M.is_lsp_active()
  if next(vim.lsp.get_active_clients()) == nil then
    return false
  end

  return true
end

local default_table = {
  ["true"] = "false",
  ["True"] = "False",
  ["TRUE"] = "FALSE",
  ["Yes"] = "No",
  ["YES"] = "NO",
  ["1"] = "0",
  ["<"] = ">",
  ["+"] = "-",
}

vim.tbl_add_reverse_lookup(default_table)
vim.tbl_add_reverse_lookup(O.toggle.user_tables)

local merged_table = vim.tbl_extend("force", default_table, O.toggle.user_tables)

local function errorHandler(err)
  if not err == nil then
    print("[toggle] Error toggling value: " .. err)
  end
end

function M.toggleString()
  local str = vim.fn.expand "<cword>"

  if merged_table[str] == nil then
    print "[toggle] Unsupported value."

    return
  end

  xpcall(vim.cmd("normal ciw" .. merged_table[str]), errorHandler)
end

return M
