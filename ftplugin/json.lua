local keymap = vim.api.nvim_buf_set_keymap

keymap(0, "i", ":", "<cmd>call v:lua.MJson.colon_complete()<cr>", { noremap = true, silent = true })
keymap(0, "i", "<cr>", "<cmd>call v:lua.MJson.comma_cr()<cr>", { noremap = true })

if vim.g.loaded_json_ftplugin then
  return
end

vim.g.loaded_json_ftplugin = true

_G.MJson = {}

local function feedkeys(key)
  vim.api.nvim_feedkeys(key, "n", true)
end

local input = vim.api.nvim_input
local modules = require "modules.indent"

function _G.MJson.colon_complete()
  local line = vim.api.nvim_get_current_line()
  local linenr, col = unpack(vim.api.nvim_win_get_cursor(0))

  local is_cursor_on_eol = #line == cursor_position

  if not is_cursor_on_eol then
    if col == 1 then
      col = 2
    end

    local string_table = vim.split(line, "")

    local before = table.concat(vim.list_slice(string_table, 1, col - 1), "")
    local after = table.concat(vim.list_slice(string_table, col, vim.fn.col "$" - 1), "")

    vim.api.nvim_set_current_line(before .. ":" .. after)

    return
  end

  local key_regex = vim.fn.substitute(line, [[^\s*"\?\w\+"\?$]], [[\0]], "")
  local has_colon = key_regex == nil or key_regex == "null"

  if has_colon then
    if col == 1 then
      col = 2
    end

    local string_table = vim.split(line, "")

    local before = table.concat(vim.list_slice(string_table, 1, col - 1), "")
    local after = table.concat(vim.list_slice(string_table, col, vim.fn.col "$" - 1), "")

    vim.api.nvim_set_current_line(before .. ":" .. after)

    return
  end

  local has_quotes = key_regex:find '"' ~= nil

  if not has_quotes then
    local quoted_result = vim.fn.substitute(line, [[^\s*\zs\w\+$]], [["\0"]], "")

    if quoted_result == nil or quoted_result == "null" then
      if col == 1 then
        col = 2
      end

      local string_table = vim.split(line, "")

      local before = table.concat(vim.list_slice(string_table, 1, col - 1), "")
      local after = table.concat(vim.list_slice(string_table, col, vim.fn.col "$" - 1), "")

      vim.api.nvim_set_current_line(before .. ":" .. after)

      return
    end

    local indent = string.rep(" ", require("nvim-treesitter.indent").get_indent())

    vim.fn.setline(linenr, indent .. quoted_result)
  end

  vim.api.nvim_set_current_line(vim.api.nvim_get_current_line() .. ": ")

  vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1], 9999 })
end

function _G.MJson.comma_cr()
  local line = vim.api.nvim_get_current_line()
  local line_column = vim.api.nvim_win_get_cursor(0)
  local linenr = line_column[1]
  local cursor_position = line_column[2]

  local is_cursor_on_eol = #line == cursor_position

  if not is_cursor_on_eol or line:sub(cursor_position, cursor_position) == "," then
    input("<CR>")

    return
  end

  vim.api.nvim_set_current_line(line .. ",")

  -- Append a line and move cursor
  vim.fn.append(".", "")

  vim.api.nvim_win_set_cursor(0, { linenr + 1, 1 })

  input(modules.smart_indent())
end
