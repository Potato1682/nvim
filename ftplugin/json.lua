local lsp_config = require "lsp"
local container = require "lspcontainers"
local schemas = require "lsp.json.schemas"

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

require("lspconfig").jsonls.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  filetypes = { "json", "jsonc" },
  cmd = container.command "jsonls",
  on_attach = lsp_config.common_on_attach,
  capabilities = capabilities,
  root_dir = vim.loop.cwd,
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
      end,
    },
  },
  settings = {
    json = {
      schemas = schemas.schemas,
    },
  },
}

local utils = require "nvim-utils.indent"

_G.MJson = {}

local function feedkeys(key)
  vim.api.nvim_feedkeys(key, "n", true)
end

local input = vim.api.nvim_input

function _G.MJson.colon_complete()
  local line = vim.fn.getline "."
  local line_column = vim.api.nvim_win_get_cursor(0)
  local linenr = line_column[1]
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

  local key_regex = vim.fn.substitute(line, [[^\s*"\?\w\+"\?$]], [[\0]], "")
  local has_colon = key_regex == nil or key_regex == "null"

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

  local has_quotes = key_regex:find '"' ~= nil

  if not has_quotes then
    local quoted_result = vim.fn.substitute(line, [[^\s*\zs\w\+$]], [["\0"]], "")

    if quoted_result == nil or quoted_result == "null" then
      if cursor_position == 1 then
        cursor_position = 2
      end

      local string_table = vim.split(line, "")

      local before = table.concat(vim.list_slice(string_table, 1, cursor_position - 1), "")
      local after = table.concat(vim.list_slice(string_table, cursor_position, vim.fn.col "$" - 1), "")

      vim.api.nvim_set_current_line(before .. ":" .. after)

      return
    end

    local indent = string.rep(" ", require("nvim-treesitter.indent").get_indent())

    vim.fn.setline(linenr, indent .. quoted_result)
  end

  vim.api.nvim_set_current_line(vim.api.nvim_get_current_line() .. ": ")

  vim.fn.cursor(vim.fn.line ".", vim.fn.col "$")
end

function _G.MJson.comma_cr()
  local line = vim.fn.getline "."
  local line_column = vim.api.nvim_win_get_cursor(0)
  local linenr = line_column[1]
  local cursor_position = line_column[2]

  local is_cursor_on_eol = #line == cursor_position

  if not is_cursor_on_eol or line:sub(cursor_position, cursor_position) == "," then
    feedkeys(_G.MUtils.enter_confirm())

    return
  end

  vim.api.nvim_set_current_line(line .. ",")

  -- Append a line and move cursor
  vim.fn.append(".", "")
  vim.fn.cursor(linenr + 1, vim.fn.col "$")

  input(utils.smart_indent())
end

local keymap = vim.api.nvim_buf_set_keymap

keymap(0, "i", ":", "<cmd>call v:lua.MJson.colon_complete()<cr>", { noremap = true, silent = true })
keymap(0, "i", "<cr>", "<cmd>call v:lua.MJson.comma_cr()<cr>", { noremap = true })
