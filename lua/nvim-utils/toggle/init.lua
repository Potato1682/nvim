local M = {}

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

local function handle_error(err)
  if not err == nil then
    print("[toggle] Error toggling value: " .. err)
  end
end

function M.toggle()
  local str = vim.fn.expand "<cword>"

  if merged_table[str] == nil then
    print "[toggle] Unsupported value."

    return
  end

  xpcall(vim.cmd("normal ciw" .. merged_table[str]), handle_error)
end

return M
