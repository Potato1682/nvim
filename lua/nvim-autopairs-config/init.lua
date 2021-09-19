local npairs = require "nvim-autopairs"
local cond = require "nvim-autopairs.conds"
local Rule = require "nvim-autopairs.rule"
local indent = require "modules.indent"

npairs.setup {
  enable_check_bracket_line = false,
  fast_wrap = {},
  map_bs = false,
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
  Rule("=", "")
    :with_pair(cond.not_inside_quote())
    :with_pair(function(options)
      local last_char = options.line:sub(options.col - 1, options.col - 1)

      return last_char:match("[%w%=%s]")
    end)
    :replace_endpair(function(options)
      local previous_2char = options.line:sub(options.col - 2, options.col - 1)
      local next_char = options.line:sub(options.col, options.col)

      next_char = next_char == " " and "" or " "

      if previous_2char:match("%w$") then
        return "<bs> =" .. next_char
      end

      if previous_2char:match("%=$") then
        return next_char
      end

      if previous_2char:match("=") then
        return "<bs><bs>=" .. next_char
      end

      return ""
    end)
    :set_end_pair_length(0)
    :with_move(cond.none())
    :with_del(cond.none())
}

npairs.add_rules(require "nvim-autopairs.rules.endwise-lua")
npairs.add_rules(require "nvim-autopairs.rules.endwise-ruby")

-- move up current line and delete old line.
-- this function is used by backspace smart indent feature.
-- @param line_string current line in string.
--        You can get this by following: `tostring(vim.api.nvim_win_get_cursor(0)[1])`
function _G.MPairs.move_and_delete(line_string)
  vim.cmd [[ nohlsearch ]]
  vim.cmd(line_string .. "d")
  vim.api.nvim_input "<esc>==wi"
end

-- replace autopairs' backspace function
function _G.MPairs.check_bs()
  local line, column = unpack(vim.api.nvim_win_get_cursor(0))
  local spaces = vim.api.nvim_get_current_line():match "^%s+"
  local _previous_lines = vim.api.nvim_buf_get_lines(0, line - 1, line - 1, false)
  local previous_line = #_previous_lines <= 0 and "" or _previous_lines[1]

  local function bs()
    vim.api.nvim_feedkeys(npairs.autopairs_bs(), "n", true)
  end

  if spaces == nil then
    bs()

    return
  end

  local matched = vim.api.nvim_get_current_line():match "^%s+$"

  -- Delete current line if the line is spaces
  if matched ~= nil then
    if indent.get_indents() ~= #matched then
      bs()

      return
    end

    local old_line = vim.api.nvim_win_get_cursor(0)[1]

    -- Check if the cursor is on last line
    -- If true, the cursor do not move up after deleting line
    if old_line == vim.fn.line "$" then
      vim.api.nvim_del_current_line()

      local new_line = vim.api.nvim_win_get_cursor(0)[1]

      vim.api.nvim_win_set_cursor(0, { new_line, 9999 })

      vim.api.nvim_input "<Tab>"

      vim.defer_fn(function()
        vim.api.nvim_input("<C-e>")
      end, 85)

      return
    end

    vim.api.nvim_del_current_line()

    local new_line = vim.api.nvim_win_get_cursor(0)[1]

    vim.api.nvim_win_set_cursor(0, { new_line - 1, 9999 })

    vim.api.nvim_input "<Tab>"
  elseif column == #spaces then
    if previous_line == nil then
      _G.MPairs.move_and_delete(tostring(line - 1))
    elseif string.match(previous_line, "^%s*$") ~= nil then
      _G.MPairs.move_and_delete(tostring(line - 1))
    else
      bs()
    end
  else
    bs()
  end

  return
end
