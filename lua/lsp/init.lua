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

function lsp_config.common_on_attach(client, bufnr)
  require("events").nvim_create_augroups {
    lsp = {
      { "CursorHold,CursorHoldI", "<buffer>", "silent! lua vim.lsp.buf.hover()" },
      { "CursorMoved,CursorMovedI", "<buffer>", "lua require'lsp-status'.update_current_function()" },
    },
  }

  local utils = require "modules"

  utils.define_command(
    "LspPreviewDefinition",
    "lua require'goto-preview'.goto_preview_definition()<cr>",
    { buffer = true }
  )
  utils.define_command("LspDefinition", "lua vim.lsp.buf.definition()", { buffer = true })
  utils.define_command(
    "LspPreviewImplementation",
    "lua require'goto-preview'.goto_preview_implementation()<cr>",
    { buffer = true }
  )
  utils.define_command("LspImplementation", "lua vim.lsp.buf.implementation()", { buffer = true })
  utils.define_command("LspCodeAction", "lua vim.lsp.buf.code_action()", { buffer = true })
  utils.define_command("LspRename", "lua require'lsp.rename'.rename()", { buffer = true })
  utils.define_command("LspReferences", "lua vim.lsp.buf.references()", { buffer = true })
  utils.define_command("LspTypeDefinition", "lua vim.lsp.buf.type_definition()", { buffer = true })
  utils.define_command("LspDiagnosticsNext", "lua vim.lsp.diagnostic.goto_next()", {})
  utils.define_command("LspDiagNext", "lua vim.lsp.diagnostic.goto_next()", {})
  utils.define_command("LspDiagnosticPrev", "lua vim.lsp.diagnostic.goto_prev()", {})
  utils.define_command("LspDiagPrev", "lua vim.lsp.diagnostic.goto_prev()", {})
  utils.define_command("LspDiagnosticsLine", "lua vim.lsp.diagnostic.show_line_diagnostics()", {})
  utils.define_command("LspDiagLine", "lua vim.lsp.diagnostic.show_line_diagnostics()", {})

  utils.define_command("LspHover", "lua vim.lsp.buf.hover()", { buffer = true })
  utils.define_command("LspSignatureHelp", "lua vim.lsp.buf.signature_help()", { buffer = true })

  local function buf_keymap(mode, key, action)
    vim.api.nvim_buf_set_keymap(bufnr, mode, key, action, { noremap = true, silent = true })
  end

  buf_keymap("n", "gd", "<cmd>LspPreviewDefinition<cr>")
  buf_keymap("n", "gD", "<cmd>LspDefinition<cr>")
  buf_keymap("n", "gi", "<cmd>LspPreviewImplementation<cr>")
  buf_keymap("n", "gI", "<cmd>LspImplementation<cr>")
  buf_keymap("n", "gr", "<cmd>LspRename<cr>")
  buf_keymap("n", "gR", "<cmd>AnyJump<cr>")

  buf_keymap("n", "gla", "<cmd>LspDiagnosticsLine<cr>")
  buf_keymap("n", "[a", "<cmd>LspDiagnosticPrev<cr>")
  buf_keymap("n", "]a", "<cmd>LspDiagnosticNext<cr>")

  buf_keymap("n", "K", "<cmd>LspHover<cr>")
  buf_keymap("i", "<C-k>", "<cmd>LspSignatureHelp<cr>")

  -- fix 'command not found' error
  vim.cmd [[ command! -nargs=0 -bang IlluminationDisable call illuminate#disable_illumination(<bang>0) ]]
  require("illuminate").on_attach(client, bufnr)
  require("lsp-status").on_attach(client, bufnr)
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

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  { signs = false, virtual_text = { spacing = 0 }, update_in_insert = true }
)

return lsp_config
