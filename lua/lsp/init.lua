vim.fn.sign_define(
  "LspDiagnosticsSignError",
  { texthl = "LspDiagnosticsSignError", text = " ", numhl = "LspDiagnosticsSignError" }
)
vim.fn.sign_define(
  "LspDiagnosticsSignWarning",
  { texthl = "LspDiagnosticsSignWarning", text = " ", numhl = "LspDiagnosticsSignWarning" }
)
vim.fn.sign_define(
  "LspDiagnosticsSignInformation",
  { texthl = "LspDiagnosticsSignInformation", text = " ", numhl = "LspDiagnosticsSignInformation" }
)
vim.fn.sign_define(
  "LspDiagnosticsSignHint",
  { texthl = "LspDiagnosticsSignHint", text = " ", numhl = "LspDiagnosticsSignHint" }
)

vim.lsp.handlers["textDocument/codeAction"] = require("lsputil.codeAction").code_action_handler
vim.lsp.handlers["textDocument/references"] = require("lsputil.locations").references_handler
vim.lsp.handlers["textDocument/definition"] = require("lsputil.locations").definition_handler
vim.lsp.handlers["textDocument/declaration"] = require("lsputil.locations").declaration_handler
vim.lsp.handlers["textDocument/typeDefinition"] = require("lsputil.locations").typeDefinition_handler
vim.lsp.handlers["textDocument/implementation"] = require("lsputil.locations").implementation_handler
vim.lsp.handlers["textDocument/documentSymbol"] = require("lsputil.symbols").document_handler
vim.lsp.handlers["workspace/symbol"] = require("lsputil.symbols").workspace_handler

local keymap = vim.api.nvim_set_keymap

keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
keymap("n", "gD", ":lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
keymap("n", "gr", ":lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true })
keymap("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", { noremap = true, silent = true })

vim.cmd "command! -nargs=0 LspVirtualTextToggle lua require'lsp.virtual-text'.toggle()"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { focusable = false })

local status = require "lsp-status"

status.register_progress()
status.config {
  diagnostics = false,
  status_symbol = "  ",
  select_symbol = function(cursor_pos, symbol)
    if symbol.valueRange then
      local value_range = {
        ["start"] = {
          character = 0,
          line = vim.fn.byte2line(symbol.valueRange[1]),
        },
        ["end"] = {
          character = 0,
          line = vim.fn.byte2line(symbol.valueRange[2]),
        },
      }

      return require("lsp-status.util").in_range(cursor_pos, value_range)
    end
  end,
  kind_labels = {
    Text = " ",
    Method = " ",
    Function = " ",
    Constructor = " ",
    Field = " ",
    Variable = "[]",
    Class = " ",
    Interface = " ",
    Module = "{} ",
    Property = " ",
    Unit = " ",
    Value = " ",
    Enum = " ",
    Keyword = " ",
    Snippet = " ",
    Color = " ",
    File = " ",
    Reference = " ",
    Folder = " ",
    EnumMember = " ",
    Constant = " ",
    Struct = " ",
    Event = " ",
    Operator = " ",
    TypeParameter = " ",
  },
}

vim.lsp.protocol.CompletionItemKind = {
  " (Text)",
  " (Method)",
  " (Function)",
  " (Constructor)",
  " (Field)",
  "[] (Variable)",
  " (Class)",
  " (Interface)",
  "{} (Module)",
  " (Property)",
  " (Unit)",
  " (Value)",
  "  (Enum)",
  " (Keyword)",
  " (Snippet)",
  " (Color)",
  " (File)",
  " (Reference)",
  " (Folder)",
  " (EnumMember)",
  " (Constant)",
  " (Struct)",
  " (Event)",
  " (Operator)",
  " (TypeParameter)",
}

local lsp_config = {}
local pos = {}

function lsp_config.common_on_attach(client, bufnr)
  require("events").nvim_create_augroups {
    lsp = {
      { "CursorHold,CursorHoldI", "<buffer>", "silent! lua vim.lsp.buf.hover()" },
      { "CursorMoved,CursorMovedI", "<buffer>", "lua require'lsp-status'.update_current_function()" },
    },
  }

  -- fix 'command not found' error
  vim.cmd [[ command! -nargs=0 -bang IlluminationDisable call illuminate#disable_illumination(<bang>0) ]]
  require("illuminate").on_attach(client, bufnr)
  require("lsp-status").on_attach(client, bufnr)
  require("virtualtypes").on_attach(client, bufnr)
  require("lsp-rooter").setup()
  require("lsp_signature").on_attach {
    bind = true,
    hint_prefix = "",
    hi_parameter = "Blue",
    handler_opts = {
      border = "none",
    },
  }
end

local api = vim.api

local window = {}

function window.nvim_close_valid_window(winid)
  local close_win = function(win_id)
    if win_id == 0 then
      return
    end

    if vim.api.nvim_win_is_valid(win_id) then
      api.nvim_win_close(win_id, true)
    end
  end

  local _switch = {
    ["table"] = function()
      for _, id in ipairs(winid) do
        close_win(id)
      end
    end,
    ["number"] = function()
      close_win(winid)
    end,
  }

  local _switch_metatable = {
    __index = function(_, t)
      error(string.format("Wrong type %s of winid", t))
    end,
  }

  setmetatable(_switch, _switch_metatable)

  _switch[type(winid)]()
end

local function make_floating_popup_options(width, height, opts)
  vim.validate {
    opts = { opts, "t", true },
  }

  opts = opts or {}

  vim.validate {
    ["opts.offset_x"] = { opts.offset_x, "n", true },
    ["opts.offset_y"] = { opts.offset_y, "n", true },
  }
  local new_option = {}

  new_option.style = "minimal"
  new_option.width = width
  new_option.height = height

  if opts.relative ~= nil then
    new_option.relative = opts.relative
  else
    new_option.relative = "cursor"
  end

  if opts.anchor ~= nil then
    new_option.anchor = opts.anchor
  end

  if opts.row == nil and opts.col == nil then
    local lines_above = vim.fn.winline() - 1
    local lines_below = vim.fn.winheight(0) - lines_above

    new_option.anchor = ""

    local pum_pos = vim.fn.pum_getpos()
    local pum_vis = not vim.tbl_isempty(pum_pos)

    if pum_vis and vim.fn.line "." >= pum_pos.row or not pum_vis and lines_above < lines_below then
      new_option.anchor = "N"
      new_option.row = 1
    else
      new_option.anchor = "S"
      new_option.row = -2
    end

    if vim.fn.wincol() + width <= api.nvim_get_option "columns" then
      new_option.anchor = new_option.anchor .. "W"

      new_option.col = 0
    else
      new_option.anchor = new_option.anchor .. "E"

      new_option.col = 1
    end
  else
    new_option.row = opts.row
    new_option.col = opts.col
  end

  return new_option
end

local function generate_win_opts(contents, opts)
  opts = opts or {}
  local win_width, win_height = vim.lsp.util._make_floating_popup_size(contents, opts)
  opts = make_floating_popup_options(win_width, win_height, opts)
  return opts
end

function window.create_win_with_border(content_opts, opts)
  vim.validate {
    content_opts = { content_opts, "t" },
    contents = { content_opts.content, "t", true },
    opts = { opts, "t", true },
  }

  local contents, filetype = content_opts.contents, content_opts.filetype
  local enter = content_opts.enter or false

  opts = opts or {}
  opts = generate_win_opts(contents, opts)
  opts.border = "single"

  local bufnr = api.nvim_create_buf(false, true)
  local content = vim.lsp.util._trim(contents)

  if filetype then
    api.nvim_buf_set_option(bufnr, "filetype", filetype)
  end

  api.nvim_buf_set_lines(bufnr, 0, -1, true, content)
  api.nvim_buf_set_option(bufnr, "modifiable", false)
  api.nvim_buf_set_option(bufnr, "bufhidden", "wipe")
  api.nvim_buf_set_option(bufnr, "buftype", "nofile")

  local winid = api.nvim_open_win(bufnr, enter, opts)
  if filetype == "markdown" then
    api.nvim_win_set_option(winid, "conceallevel", 2)
  end

  api.nvim_win_set_option(winid, "winblend", 0)
  api.nvim_win_set_option(winid, "foldlevel", 100)

  return bufnr, winid
end

local function apply_action_keys()
  local quit_key = "q"
  local exec_key = "<cr>"

  api.nvim_command("inoremap <buffer><nowait><silent>" .. exec_key .. " <cmd>lua require'lsp'.do_rename()<cr>")

  if type(quit_key) == "table" then
    for _, k in ipairs(quit_key) do
      api.nvim_command("inoremap <buffer><nowait><silent>" .. k .. " <cmd>lua require'lsp'.close_rename_window()<cr>")
    end
  else
    api.nvim_command(
      "inoremap <buffer><nowait><silent>" .. quit_key .. " <cmd>lua require'lsp'.close_rename_window()<cr>"
    )
  end

  api.nvim_command "nnoremap <buffer><silent>q <cmd>lua require'lsp'.close_rename_window()<cr>"
end

local unique_name = "textDocument-rename"

function lsp_config.rename()
  local active = require("modules").is_lsp_active()

  if not active then
    return
  end

  lsp_config.close_rename_window()

  pos[1], pos[2] = vim.fn.line ".", vim.fn.col "."

  local opts = {
    height = 1,
    width = 30,
  }

  local content_opts = {
    contents = {},
    filetype = "",
    enter = true,
    highlight = "FloatBorder",
  }

  local bufnr, winid = window.create_win_with_border(content_opts, opts)
  local rename_prompt_prefix = api.nvim_create_namespace "rename_prompt_prefix"

  api.nvim_win_set_option(winid, "scrolloff", 0)
  api.nvim_win_set_option(winid, "sidescrolloff", 0)
  api.nvim_buf_set_option(bufnr, "modifiable", true)

  local prompt_prefix = "❯ "

  api.nvim_buf_set_option(bufnr, "buftype", "prompt")
  vim.fn.prompt_setprompt(bufnr, prompt_prefix)
  api.nvim_buf_add_highlight(bufnr, rename_prompt_prefix, "Blue", 0, 0, #prompt_prefix)
  vim.cmd [[ startinsert! ]]
  api.nvim_win_set_var(0, unique_name, winid)
  api.nvim_command "autocmd QuitPre <buffer> ++nested ++once :silent lua require'lsp'.close_rename_window()"

  apply_action_keys()
end

function lsp_config.do_rename()
  local prompt_prefix = "❯ "
  local new_name = vim.trim(vim.fn.getline("."):sub(#prompt_prefix + 1, -1))

  lsp_config.close_rename_window()

  local params = vim.lsp.util.make_position_params()
  local current_name = vim.fn.expand "<cword>"

  if not (new_name and #new_name > 0) or new_name == current_name then
    return
  end

  params.newName = new_name

  vim.lsp.buf_request(0, "textDocument/rename", params)
end

function lsp_config.close_rename_window()
  if vim.fn.mode() == "i" then
    vim.cmd [[ stopinsert ]]
  end

  local has, winid = pcall(api.nvim_win_get_var, 0, unique_name)

  if has then
    window.nvim_close_valid_window(winid)
    api.nvim_win_set_cursor(0, pos)
    pos = {}
  end
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  { signs = false, virtual_text = { spacing = 0 }, update_in_insert = true }
)

return lsp_config
