local M = {}

local last_char = nil
local last_ending = nil
local valid_endings = {
  "')",
  '")',
  "'",
  '"',
  ")",
  "]",
  "}",
  ")}",
  "]}",
  "')}",
  '")}',
  '("")',
  "('')",
}

local function get_word()
  return vim.fn.expand("<cword>")
end

local function t(key)
  return vim.api.nvim_replace_termcodes(key, true, true, true)
end

local function has_valid_ending(word)
    for _, value in ipairs(valid_endings) do
        if word:sub(-string.len(value)) == value then
            last_ending = value

            return true
        end
    end

    last_ending = nil

    return false
end

local function word_at_end_line(word, line)
  return line:sub(-string.len(word)) == word
end

function M.smart_semicolon(char)
  local word = get_word()
  local line = vim.api.nvim_get_current_line()

  if has_valid_ending(word) then
    last_char = char
  else
    last_char = nil
  end

  return last_char ~= nil and word_at_end_line(word, line) and t("<C-o>A" .. char) or char
end

function M.undo()
  if last_ending == nil then
    return t "<BS>"
  else
    local word_length = string.len(last_ending) - 1

    if word_length == 3 then
      word_length = 1
    end

    last_ending = nil

    return t("<BS><C-c>" .. word_length .. "hi" .. last_char)
  end
end

return M
