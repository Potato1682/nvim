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
  local augroup = require("events").nvim_create_augroups

  augroup {
    lsp = {
      { "CursorMoved,CursorMovedI", "<buffer>", "lua require'lsp-status'.update_current_function()" },
      { "CursorMoved,CursorMovedI", "<buffer>", "lua vim.lsp.codelens.refresh()" }
    },
  }

  local function buf_keymap(mode, key, action)
    vim.api.nvim_buf_set_keymap(bufnr, mode, key, action, { noremap = true, silent = true })
  end

  local command = require("modules").define_command
  local cap = client.resolved_capabilities

  if cap.declaration then
    command("LspDeclaration", "lua vim.lps.buf.declaration()", { buffer = true })
  end

  if cap.goto_definition then
    command(
      "LspPreviewDefinition",
      "lua require'goto-preview'.goto_preview_definition()",
      { buffer = true }
    )
    buf_keymap("n", "gd", "<cmd>LspPreviewDefinition<cr>")

    command("LspDefinition", "lua vim.lsp.buf.definition()", { buffer = true })
    buf_keymap("n", "gD", "<cmd>LspDefinition<cr>")
  end

  if cap.type_definition then
    command("LspTypeDefinition", "lua vim.lsp.buf.type_definition()", { buffer = true })
  end

  if cap.implementation then
    command(
      "LspPreviewImplementation",
      "lua require'goto-preview'.goto_preview_implementation()",
      { buffer = true }
    )
    buf_keymap("n", "gi", "<cmd>LspPreviewImplementation<cr>")

    command("LspImplementation", "lua vim.lsp.buf.implementation()", { buffer = true })
    buf_keymap("n", "gI", "<cmd>LspImplementation<cr>")
  end

  if cap.code_action then
    command("LspCodeAction", "lua require'lsp.code_action'.code_action(<range> ~= 0, <line1>, <line2>)", { buffer = true })
  end

  if cap.rename then
    command("LspRename", "lua require'lsp.rename'.rename(<f-args>)", { buffer = true, nargs = "?", complete = "custom,v:lua.require'lsp.completion'.rename" })
    buf_keymap("n", "gr", "<cmd>LspRename<cr>")
  end

  if cap.find_references then
    command("LspReferences", "lua vim.lsp.buf.references()", { buffer = true })
  end

  if cap.document_symbol then
    command("LspDocumentSymbol", "lua vim.lsp.buf.document_symbol()", { buffer = true })
  end

  if cap.workspace_symbol then
    command("LspWorkspaceSymbol", "lua vim.lsp.buf.workspace_symbol(<f-args>)", { buffer = true, nargs = "?", complete = "custom,v:lua.require'lsp.completion'.workspace_symbol" })
  end

  if cap.call_hierarchy then
    command("LspIncomingCalls", "lua vim.lsp.buf.incoming_calls()", { buffer = true })
    command("LspOutgoingCalls", "lua vim.lsp.buf.outgoing_calls()", { buffer = true })
  end

  if cap.code_lens then
    command("LspCodeLensRun", "lua vim.lsp.codelens.run()", { buffer = true })
  end

  command("LspWorkspaceFolders", "lua print(table.concat(vim.lsp.buf.list_workspace_folders(), '\\n'))", { buffer = true })

  if cap.workspace_folder_properties.supported then
    command("LspAddWorkspaceFolder", "lua vim.lsp.buf.add_workspace_folder(<q-args> ~= '' and vim.fn.fnamemodify(<q-args>, ':p'))", { buffer = true, nargs = "?", complete = "dir" })
    command("LspRemoveWorkspaceFolder", "lua vim.lsp.buf.remove_workspace_folder(<f-args>)", { buffer = true, nargs = "?", complete = "custom,v:lua.vim.lsp.buf.list_workspace_folders" })
  end

  command("LspDiagnosticsNext", "lua vim.lsp.diagnostic.goto_next()", { buffer = true })
  command("LspDiagNext", "lua vim.lsp.diagnostic.goto_next()", { buffer = true })
  command("LspDiagnosticPrev", "lua vim.lsp.diagnostic.goto_prev()", { buffer = true })
  command("LspDiagPrev", "lua vim.lsp.diagnostic.goto_prev()", { buffer = true })
  command("LspDiagnosticsLine", "lua vim.lsp.diagnostic.show_line_diagnostics()", {})
  command("LspDiagLine", "lua vim.lsp.diagnostic.show_line_diagnostics()", { buffer = true })
  buf_keymap("n", "gla", "<cmd>LspDiagnosticsLine<cr>")
  buf_keymap("n", "[a", "<cmd>LspDiagnosticPrev<cr>")
  buf_keymap("n", "]a", "<cmd>LspDiagnosticNext<cr>")

  command("LspLog", "execute '<mods> pedit +$' v:lua.vim.lsp.get_log_path()")

  if cap.hover then
    command("LspHover", "lua vim.lsp.buf.hover()", { buffer = true })
    buf_keymap("n", "K", "<cmd>LspHover<cr>")

    augroup {
      lsphover = {
        { "CursorHold,CursorHoldI", "<buffer>", "silent! lua vim.lsp.buf.hover()" },
      }
    }
  end

  if cap.signature_help then
    command("LspSignatureHelp", "lua vim.lsp.buf.signature_help()", { buffer = true })
    buf_keymap("i", "<C-k>", "<cmd>LspSignatureHelp<cr>")
  end

  buf_keymap("n", "gR", "<cmd>AnyJump<cr>")

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
