_G.MYaml = {}

vim.cmd [[ TSBufEnable indent ]]

function _G.MYaml.colon_complete()
  local line = vim.fn.getline "."
  local line_column = vim.api.nvim_win_get_cursor(0)
  local cursor_position = line_column[2]

  local is_cursor_on_eol = #line == cursor_position

  if not is_cursor_on_eol then
    if cursor_position == 1 then
      cursor_position = 2
    end

    local string_table = vim.split(line, "")

    local before = table.concat(vim.list_slice(string_table, 1, cursor_position - 1), "")
    local after = table.concat(vim.list_slice(string_table, cursor_position, vim.fn.col "$" - 1), "")

    vim.api.nvim_set_current_line(before .. ":" .. after)

    return
  end

  local key_regex = vim.fn.substitute(line, [[^\s*[\w-]:\?$]], [[\0]], "")
  local is_key_nothing = key_regex == nil or key_regex == "null"

  if is_key_nothing then
    if cursor_position == 1 then
      cursor_position = 2
    end

    local string_table = vim.split(line, "")

    local before = table.concat(vim.list_slice(string_table, 1, cursor_position - 1), "")
    local after = table.concat(vim.list_slice(string_table, cursor_position, vim.fn.col "$" - 1), "")

    vim.api.nvim_set_current_line(before .. ":" .. after)

    return
  end

  local has_colon = key_regex:find ":"

  if has_colon then
    if cursor_position == 1 then
      cursor_position = 2
    end

    local string_table = vim.split(line, "")

    local before = table.concat(vim.list_slice(string_table, 1, cursor_position - 1), "")
    local after = table.concat(vim.list_slice(string_table, cursor_position, vim.fn.col "$" - 1), "")

    vim.api.nvim_set_current_line(before .. ":" .. after)

    return
  end

  vim.api.nvim_set_current_line(line .. ": ")

  vim.fn.cursor(vim.fn.line ".", vim.fn.col "$")
end

vim.api.nvim_buf_set_keymap(
  0,
  "i",
  ":",
  "<cmd>call v:lua.MYaml.colon_complete()<cr>",
  { noremap = true, silent = true }
)
