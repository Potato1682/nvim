local npairs = require "nvim-autopairs"
local Rule = require "nvim-autopairs.rule"
local indent = require "modules.indent"

npairs.setup {
  enable_check_bracket_line = false,
  fast_wrap = {},
  map_bs = false
}

require("nvim-autopairs.completion.cmp").setup {
  map_cr = true,
  map_complete = true,
}

npairs.add_rules {
  Rule(" ", " "):with_pair(function(options)
    local pair = options.line:sub(options.col - 1, options.col)

    return vim.tbl_contains({ "()", "{}", "[]" }, pair)
  end),
  Rule("( ", " )")
    :with_pair(function(_)
      return false
    end)
    :with_move(function(options)
      return options.prev_char:match ".%)" ~= nil
    end)
    :use_key ")",
  Rule("{ ", " }")
    :with_pair(function(_)
      return false
    end)
    :with_move(function(options)
      return options.prev_char:match ".%}" ~= nil
    end)
    :use_key "}",
  Rule('"""', '"""', "toml"),
  Rule("[ ", " ]")
    :with_pair(function(_)
      return false
    end)
    :with_move(function(options)
      return options.prev_char:match ".%]" ~= nil
    end)
    :use_key "}",
  Rule(
    "%(.*%)%s*%=>$",
    " {  }",
    { "typescript", "typescriptreact", "javascript", "javascriptreact", "typescript.tsx", "javascript.jsx" }
  ):use_regex(true):set_end_pair_length(2),
}

npairs.add_rules(require "nvim-autopairs.rules.endwise-lua")
npairs.add_rules(require "nvim-autopairs.rules.endwise-ruby")

-- move up current line and delete old line.
-- this function is used by backspace smart indent feature.
-- @param line_string current line in string. You can get this by following: `tostring(vim.api.nvim_win_get_cursor(0)[1])`
function _G.MPairs.move_and_delete(line_string)
  vim.cmd [[ nohlsearch ]]
  vim.cmd(line_string .. "d")
  vim.api.nvim_input "<esc>==wi"
end

-- replace autopairs' backspace function
function _G.MPairs.check_bs()
  local lc = vim.api.nvim_win_get_cursor(0)
  local line = lc[1]
  local column = lc[2]
  local spaces = vim.fn.getline("."):match "^%s+"
  local previous_line = vim.fn.getline(tostring(line - 1))

  if spaces == nil then
    vim.api.nvim_feedkeys(npairs.autopairs_bs(vim.api.nvim_get_current_buf()), "n", true)

    return ""
  end

  local matched = vim.fn.getline("."):match "^%s+$"

  -- Delete current line if the line is spaces
  if matched ~= nil then
    if indent.get_indents() ~= #matched then
      vim.api.nvim_feedkeys(npairs.autopairs_bs(vim.api.nvim_get_current_buf()), "n", true)

      return ""
    end

    -- Check if the cursor is on last line
    -- If true, the cursor do not move up after deleting line
    if vim.fn.line "." == vim.fn.line "$" then
      vim.api.nvim_input "<esc>ddA"

      return indent.smart_indent()
    end

    vim.api.nvim_input "<esc>ddkA"

    return indent.smart_indent()
  elseif column == #spaces then
    if previous_line == nil then
      _G.MPairs.move_and_delete(tostring(line - 1))
    elseif string.match(previous_line, "^%s*$") ~= nil then
      _G.MPairs.move_and_delete(tostring(line - 1))
    else
      vim.api.nvim_feedkeys(npairs.autopairs_bs(vim.api.nvim_get_current_buf()), "n", true)
    end
  else
    vim.api.nvim_feedkeys(npairs.autopairs_bs(vim.api.nvim_get_current_buf()), "n", true)
  end

  return ""
end
