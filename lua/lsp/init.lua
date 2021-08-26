vim.lsp.handlers["textDocument/codeAction"] = require("lsputil.codeAction").code_action_handler
vim.lsp.handlers["textDocument/references"] = require("lsputil.locations").references_handler
vim.lsp.handlers["textDocument/definition"] = require("lsputil.locations").definition_handler
vim.lsp.handlers["textDocument/declaration"] = require("lsputil.locations").declaration_handler
vim.lsp.handlers["textDocument/typeDefinition"] = require("lsputil.locations").typeDefinition_handler
vim.lsp.handlers["textDocument/implementation"] = require("lsputil.locations").implementation_handler
vim.lsp.handlers["textDocument/documentSymbol"] = require("lsputil.symbols").document_handler
vim.lsp.handlers["workspace/symbol"] = require("lsputil.symbols").workspace_handler

local keymap = vim.api.nvim_set_keymap

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { focusable = false })

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

local installer = require "nvim-lsp-installer"
local server = require "nvim-lsp-installer.server"
local capabilities = vim.lsp.protocol.make_client_capabilities()
local util = require "lspconfig.util"

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

local M = {}

function M.common_on_attach(client, bufnr)
  local augroup = require("events").nvim_create_augroups

  augroup {
    lsp = {
      { "CursorMoved,CursorMovedI", "<buffer>", "lua require'lsp-status'.update_current_function()" },
    },
  }

  local function buf_keymap(mode, key, action)
    vim.api.nvim_buf_set_keymap(bufnr, mode, key, action, { noremap = true, silent = true })
  end

  local command = require("modules").define_command
  local cap = client.resolved_capabilities

  if cap.declaration then
    command("LspDeclaration", "lua vim.lps.buf.declaration()", { buffer = true })

    buf_keymap("n", "gC", ":lua vim.lsp.buf.declaration()<cr>", { noremap = true, silent = true })
  end

  if cap.goto_definition then
    command("LspPreviewDefinition", "lua require'goto-preview'.goto_preview_definition()", { buffer = true })

    buf_keymap("n", "gd", "<cmd>LspPreviewDefinition<cr>")

    command("LspDefinition", "lua vim.lsp.buf.definition()", { buffer = true })

    buf_keymap("n", "gD", "<cmd>LspDefinition<cr>")
  end

  if cap.type_definition then
    command("LspTypeDefinition", "lua vim.lsp.buf.type_definition()", { buffer = true })
  end

  if cap.implementation then
    command("LspPreviewImplementation", "lua require'goto-preview'.goto_preview_implementation()", { buffer = true })

    buf_keymap("n", "gi", "<cmd>LspPreviewImplementation<cr>")

    command("LspImplementation", "lua vim.lsp.buf.implementation()", { buffer = true })

    buf_keymap("n", "gI", "<cmd>LspImplementation<cr>")
  end

  if cap.code_action then
    command(
      "LspCodeAction",
      "lua require'lsp.code_action'.code_action(<range> ~= 0, <line1>, <line2>)",
      { buffer = true }
    )
  end

  if cap.rename then
    command(
      "LspRename",
      "lua require'lsp.rename'.rename(<f-args>)",
      { buffer = true, nargs = "?", complete = "custom,v:lua.require'lsp.completion'.rename" }
    )
    buf_keymap("n", "gr", "<cmd>LspRename<cr>")
  end

  if cap.find_references then
    command("LspReferences", "lua vim.lsp.buf.references()", { buffer = true })

    buf_keymap("n", "<a-n>", "<cmd>lua require'illuminate'.next_reference({ wrap = true })<cr>", { noremap = true })
    buf_keymap(
      "n",
      "<a-p>",
      "<cmd>lua require'illuminate'.next_reference({ wrap = true, reverse = true })<cr>",
      { noremap = true }
    )
    buf_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", { noremap = true })
  end

  if cap.document_symbol then
    command("LspDocumentSymbol", "lua vim.lsp.buf.document_symbol()", { buffer = true })
  end

  if cap.workspace_symbol then
    command(
      "LspWorkspaceSymbol",
      "lua vim.lsp.buf.workspace_symbol(<f-args>)",
      { buffer = true, nargs = "?", complete = "custom,v:lua.require'lsp.completion'.workspace_symbol" }
    )
  end

  if cap.call_hierarchy then
    command("LspIncomingCalls", "lua vim.lsp.buf.incoming_calls()", { buffer = true })
    command("LspOutgoingCalls", "lua vim.lsp.buf.outgoing_calls()", { buffer = true })
  end

  if cap.code_lens then
    augroup {
      code_lens = {
        { "CursorMoved,CursorMovedI", "<buffer>", "lua vim.lsp.codelens.refresh()" },
      },
    }
    command("LspCodeLensRun", "lua vim.lsp.codelens.run()", { buffer = true })
  end

  command(
    "LspWorkspaceFolders",
    "lua print(table.concat(vim.lsp.buf.list_workspace_folders(), '\\n'))",
    { buffer = true }
  )

  if cap.workspace_folder_properties.supported then
    command(
      "LspAddWorkspaceFolder",
      "lua vim.lsp.buf.add_workspace_folder(<q-args> ~= '' and vim.fn.fnamemodify(<q-args>, ':p'))",
      { buffer = true, nargs = "?", complete = "dir" }
    )
    command(
      "LspRemoveWorkspaceFolder",
      "lua vim.lsp.buf.remove_workspace_folder(<f-args>)",
      { buffer = true, nargs = "?", complete = "custom,v:lua.vim.lsp.buf.list_workspace_folders" }
    )
  end

  command("LspDiagnosticsNext", "lua vim.lsp.diagnostic.goto_next()", { buffer = true })
  command("LspDiagNext", "lua vim.lsp.diagnostic.goto_next()", { buffer = true })
  command("LspDiagnosticPrev", "lua vim.lsp.diagnostic.goto_prev()", { buffer = true })
  command("LspDiagPrev", "lua vim.lsp.diagnostic.goto_prev()", { buffer = true })
  command("LspDiagnosticsLine", "lua vim.lsp.diagnostic.show_line_diagnostics()", { buffer = true })
  command("LspDiagLine", "lua vim.lsp.diagnostic.show_line_diagnostics()", { buffer = true })

  buf_keymap("n", "gla", "<cmd>LspDiagnosticsLine<cr>")
  buf_keymap("n", "[a", "<cmd>LspDiagnosticPrev<cr>")
  buf_keymap("n", "]a", "<cmd>LspDiagnosticNext<cr>")

  command("LspLog", "execute '<mods> pedit +$' v:lua.vim.lsp.get_log_path()", {})
  command("LspVirtualTextToggle", "lua require'lsp.virtual-text'.toggle()", { nargs = 0 })

  if cap.hover then
    command("LspHover", "lua vim.lsp.buf.hover()", { buffer = true })

    buf_keymap("n", "K", "<cmd>LspHover<cr>")

    augroup {
      lsphover = {
        { "CursorHold,CursorHoldI", "<buffer>", "silent! lua vim.lsp.buf.hover()" },
      },
    }
  end

  if cap.signature_help then
    command("LspSignatureHelp", "lua vim.lsp.buf.signature_help()", { buffer = true })

    buf_keymap("i", "<C-k>", "<cmd>LspSignatureHelp<cr>")
  end

  -- fix 'command not found' error
  command("IlluminationDisable", "call illuminate#disable_illumination(<bang>0)", { nargs = 0, bang = true })
  require("illuminate").on_attach(client, bufnr)
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

local tsserver_root = server.get_server_root_path "tsserver"

installer.register(server.Server:new {
  name = "tsserver",
  root_dir = tsserver_root,
  installer = require("nvim-lsp-installer.installers.npm").packages {
    "typescript",
    "typescript-language-server",
    "typescript-deno-plugin",
  },
  default_options = {
    init_options = {
      hostInfo = "neovim",
      plugins = {
        name = "typescript-deno-plugin",
        location = tsserver_root,
        enableForWorkspaceTypeScriptVersions = true,
      },
    },
  },
})

installer.register(server.Server:new {
  name = "jdtls",
  root_dir = server.get_server_root_path "jdtls",
  installer = require("nvim-lsp-installer.installers.zx").file(vim.fn.stdpath "config" .. "lua/lsp/java/install.mjs"),
  default_options = vim.tbl_deep_extend("error", {}),
})

installer.on_server_ready(function(server)
  local opts = {
    capabilities = capabilities,
    on_attach = common_on_attach,
  }

  if vim.tbl_contains({ "html", "jsonls" }, server.name) then
    opts.root_dir = vim.loop.cwd
  end

  if server.name == "jsonls" then
    local schemas = require "lsp.json.schemas"

    opts.settings = {
      json = {
        schemas = schemas.schemas,
      },
    }
  end

  if server.name == "vuels" then
    opts.init_options = {
      config = {
        vetur = {
          completion = {
            autoImport = true,
            useScaffoldSnippets = true,
          },
          experimental = {
            templateInterPolationService = true,
          },
          format = {
            defaultFormatter = {
              js = "eslint",
              ts = "eslint",
            },
            options = {
              tabSize = vim.opt.tabstop:get(),
              useTabs = not vim.opt.expandtab:get(),
            },
            scriptInitialIndent = O.vue.initial_indent.script,
            styleInitialIndent = O.vue.initial_indent.style,
          },
        },
      },
    }
  end

  if server.name == "pyright" then
    opts.settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true,
        },
      },
    }
  end

  if server.name == "tsserver" then
    opts.on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false

      common_on_attach(client, bufnr)

      if O.typescript.on_save.organize_imports then
        require("events").nvim_create_autocmd {
          "BufWritePre",
          "<buffer>",
          "require'nvim-lsp-installer.extras.tsserver'.organize_imports(bufnr)",
        }
      end
    end
  end

  if server.name == "eslintls" then
    opts.on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = true

      common_on_attach(client, bufnr)
    end

    opts.settings = {
      format = {
        enable = true,
      },
    }
  end

  if server.name == "denols" then
    opts.init_options = {
      enable = true,
      lint = true,
      unstable = true,
      codeLens = {
        implementations = true,
        references = true,
      },
    }
    opts.settings = {
      deno = {
        enable = true,
        lint = true,
        unstable = true,
        codeLens = {
          implementations = true,
          references = true,
        },
      },
    }
  end

  if server.name == "sumneko_lua" then
    local runtime_path = vim.split(package.path, ";")

    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    local libraries = { [vim.fn.expand "$VIMRUNTIME/lua"] = true, [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true }

    libraries = vim.tbl_extend("error", libraries, vim.api.nvim_get_runtime_file("", true))

    opts.filetypes = { "lua" }

    opts.root_dir = util.root_pattern(".git", vim.loop.cwd())

    opts.settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
          path = runtime_path,
        },
        completion = {
          callSnippet = "Both",
        },
        diagnostics = {
          globals = { "vim" },
        },
        hint = {
          enable = true,
        },
        workspace = {
          maxPreload = 10000,
          library = libraries,
        },
        telemetry = {
          enable = false,
        },
      },
    }
  end

  if server.name == "clangd" then
    opts.init_options = {
      clangdFileStatus = true,
    }
  end

  if server.name == "jdtls" then
    local jdtls_bin

    if vim.fn.has "mac" == 1 then
      jdtls_bin = "java-mac-ls"
    elseif vim.fn.has "unix" == 1 then
      jdtls_bin = "java-linux-ls"
    end

    local bundles = {
      vim.fn.glob(
        vim.fn.stdpath "data"
          .. "/dapinstall/java/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
      ),
    }

    vim.list_extend(
      bundles,
      vim.split(vim.fn.glob(vim.fn.stdpath "data" .. "/dapinstall/java/java-test/server/*.jar"), "\n")
    )

    vim.list_extend(
      bundles,
      vim.split(vim.fn.glob(vim.fn.stdpath "data" .. "/lsp_servers/jdtls/java-decompiler/server/*.jar"), "\n")
    )

    local on_attach = function(client, bufnr)
      require("jdtls").setup_dap { hotcoderplace = "auto" }
      require("lsp").common_on_attach(client, bufnr)
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities.workspace = capabilities.workspace or {}
    capabilities.workspace.configuration = true

    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
      },
    }

    capabilities.window = capabilities.window or {}
    capabilities.window.workDoneProgress = true

    local extendedClientCapabilities = require("jdtls").extendedClientCapabilities

    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

    require("jdtls").start_or_attach {
      before_init = function()
        vim.notify("Starting eclipse.jdt.ls, this take a while...", "info", { title = "jdtls" })
      end,
      cmd = { vim.fn.stdpath "config" .. "/bin/" .. bin },
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = require("jdtls.setup").find_root { "build.gradle", "pom.xml", ".git" },
      init_options = {
        bundles = bundles,
        extendedClientCapabilities = extendedClientCapabilities,
      },
      flags = {
        allow_incremental_sync = true,
      },
      settings = {
        java = {
          format = {
            enabled = O.java.format.enabled,
            settings = {
              url = vim.fn.stdpath "config" .. "/lua/lsp/java/styles/" .. O.java.format.name .. ".xml",
              profile = O.java.format.profile,
            },
          },
          referenceCodeLens = O.java.codelens.references,
          implementationCodeLens = O.java.codelens.implementation,
          signatureHelp = {
            enabled = true,
          },
          contentProvider = {
            preferred = "fernflower",
          },
          completion = {
            favoriteStaticMembers = {
              "org.hamcrest.MatcherAssert.assertThat",
              "org.hamcrest.Matchers.*",
              "org.hamcrest.CoreMatchers.*",
              "org.junit.Assert.*",
              "org.junit.Assume.*",
              "org.junit.jupiter.api.Assertions.*",
              "org.junit.jupiter.api.Assumptions.*",
              "org.junit.jupiter.api.DynamicContainer.*",
              "org.junit.jupiter.api.DynamicTest.*",
              "java.util.Objects.requireNonNull",
              "java.util.Objects.requireNonNullElse",
              "org.mockito.Mockito.*",
              "org.mockito.ArgumentMatchers.*",
              "org.mockito.Answers.*",
              "org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*",
              "org.springframework.test.web.servlet.result.MockMvcResultMatchers.*",
            },
          },
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
          configuration = {
            runtimes = O.java.runtimes,
            updateBuildConfiguration = "automatic",
          },
          autobuild = {
            enabled = O.java.autobuild,
          },
          import = {
            gradle = {
              enabled = true,
            },
            maven = {
              enabled = true,
            },
            exclusions = {
              "**/node_modules/**",
              "**/.metadata/**",
              "**/archetype-resources",
              "**/META-INF/maven/**",
              "**/test/**",
            },
          },
        },
      },
    }

    return
  end

  server:setup(opts)

  vim.cmd [[ do User LspAttachBuffers ]]
end)

return M
