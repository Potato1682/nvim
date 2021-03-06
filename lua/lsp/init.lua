if vim.fn.has "nvim-0.5.1" == 1 then
  vim.lsp.handlers["textDocument/codeAction"] = require("lsputil.codeAction").code_action_handler
  vim.lsp.handlers["textDocument/references"] = require("lsputil.locations").references_handler
  vim.lsp.handlers["textDocument/definition"] = require("lsputil.locations").definition_handler
  vim.lsp.handlers["textDocument/declaration"] = require("lsputil.locations").declaration_handler
  vim.lsp.handlers["textDocument/typeDefinition"] = require("lsputil.locations").typeDefinition_handler
  vim.lsp.handlers["textDocument/implementation"] = require("lsputil.locations").implementation_handler
  vim.lsp.handlers["textDocument/documentSymbol"] = require("lsputil.symbols").document_handler
  vim.lsp.handlers["workspace/symbol"] = require("lsputil.symbols").workspace_handler
else
  local bufnr = vim.api.nvim_buf_get_number(0)

  vim.lsp.handlers["textDocument/codeAction"] = function(_, _, actions)
    require("lsputil.codeAction").code_action_handler(nil, actions, nil, nil, nil)
  end

  vim.lsp.handlers["textDocument/references"] = function(_, _, result)
    require("lsputil.locations").references_handler(nil, result, { bufnr = bufnr }, nil)
  end

  vim.lsp.handlers["textDocument/definition"] = function(_, method, result)
    require("lsputil.locations").definition_handler(nil, result, { bufnr = bufnr, method = method }, nil)
  end

  vim.lsp.handlers["textDocument/declaration"] = function(_, method, result)
    require("lsputil.locations").declaration_handler(nil, result, { bufnr = bufnr, method = method }, nil)
  end

  vim.lsp.handlers["textDocument/typeDefinition"] = function(_, method, result)
    require("lsputil.locations").typeDefinition_handler(nil, result, { bufnr = bufnr, method = method }, nil)
  end

  vim.lsp.handlers["textDocument/implementation"] = function(_, method, result)
    require("lsputil.locations").implementation_handler(nil, result, { bufnr = bufnr, method = method }, nil)
  end

  vim.lsp.handlers["textDocument/documentSymbol"] = function(_, _, result, _, bufn)
    require("lsputil.symbols").document_handler(nil, result, { bufnr = bufn }, nil)
  end

  vim.lsp.handlers["textDocument/symbol"] = function(_, _, result, _, bufn)
    require("lsputil.symbols").workspace_handler(nil, result, { bufnr = bufn }, nil)
  end
end

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { focusable = false })

vim.lsp.protocol.CompletionItemKind = {
  "??? (Text)",
  "??? (Method)",
  "??? (Function)",
  "??? (Constructor)",
  "??? (Field)",
  "[???] (Variable)",
  "??? (Class)",
  "??? (Interface)",
  "{} (Module)",
  "??? (Property)",
  "??? (Unit)",
  "??? (Value)",
  " ??? (Enum)",
  "??? (Keyword)",
  "??? (Snippet)",
  "??? (Color)",
  "??? (File)",
  "??? (Reference)",
  "??? (Folder)",
  "??? (EnumMember)",
  "??? (Constant)",
  "??? (Struct)",
  "??? (Event)",
  "??? (Operator)",
  "??? (TypeParameter)",
}

local installer = require "nvim-lsp-installer"
local lsp = require "nvim-lsp-installer.server"
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.workspace.configuration = true
capabilities.window.workDoneProgress = true
capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

local function common_on_attach(client, bufnr)
  local augroup = require("events").nvim_create_augroups

  local function buf_keymap(mode, key, action)
    vim.api.nvim_buf_set_keymap(bufnr, mode, key, action, { noremap = true, silent = true })
  end

  local command = require("modules").define_command
  local cap = client.resolved_capabilities

  if cap.declaration then
    command("LspDeclaration", "lua vim.lps.buf.declaration()", { buffer = true })

    buf_keymap("n", "gC", ":lua vim.lsp.buf.declaration()<cr>")
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

    buf_keymap("n", "<a-n>", "<cmd>lua require'illuminate'.next_reference({ wrap = true })<cr>")
    buf_keymap("n", "<a-p>", "<cmd>lua require'illuminate'.next_reference({ wrap = true, reverse = true })<cr>")
    buf_keymap("n", "gR", "<cmd>Lspreferences<cr>")
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
  require("lsp_signature").on_attach({
    bind = true,
    hint_prefix = "",
    hi_parameter = "Blue",
    handler_opts = {
      border = "none",
    },
    fix_pos = function(signatures, lspclient)
      if signatures[1].activeParameter >= 0 and #signatures[1].parameters == 1 then
        return false
      end
      if lspclient.name == "sumneko_lua" then
        return true
      end
      return false
    end,
  }, bufnr)
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  { signs = false, virtual_text = { spacing = 0 }, update_in_insert = true }
)

local tsserver_root = lsp.get_server_root_path "tsserver"

installer.register(lsp.Server:new {
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

installer.register(lsp.Server:new {
  name = "jdtls",
  root_dir = lsp.get_server_root_path "jdtls",
  installer = require("nvim-lsp-installer.installers.zx").file(config_dir .. "lua/lsp/java/install.mjs"),
  default_options = {},
})

installer.on_server_ready(function(server)
  local util = require "lspconfig.util"
  local Path = require "plenary.path"

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
    local a = require "plenary.async_lib"
    local async, await = a.async, a.await

    local defer_setup = async(function(fn)
      local defer_opts = vim.deepcopy(opts)
      local defer_server = vim.deepcopy(server)
      local name, python_bin = await(fn)

      if name ~= nil then
        defer_opts.settings = {
          python = {
            pythonPath = python_bin,
          },
        }

        CURRENT_VENV = name
      end

      defer_opts.settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = "workspace",
            useLibraryCodeForTypes = true,
          },
        },
      }

      defer_server:setup(defer_opts)
    end)

    local function find_python_bin()
      local fname = vim.fn.expand "%:p"

      local root_files = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        "pyrightconfig.json",
      }
      local root_dir = util.root_pattern(unpack(root_files))(fname)
        or util.find_git_ancestor(fname)
        or util.path.dirname(fname)

      if root_dir == nil then
        return
      end

      local poetry_file = Path:new(root_dir .. "/pyproject.toml")
      local pipenv_file = Path:new(root_dir .. "/Pipfile")
      local venv_dir = Path:new(root_dir .. "/.venv")

      if vim.env.VIRTUAL_ENV ~= nil then
        return "venv", vim.fn.exepath "python"
      elseif poetry_file:is_file() then
        if vim.fn.executable "poetry" ~= 1 then
          return
        end

        local toml_ok, toml = pcall(require, "toml")

        if not toml_ok then
          vim.notify(
            "lua-toml rocks not installed!\nlsp will disable poetry support for pyright.",
            vim.log.levels.WARN,
            { title = "lsp" }
          )

          return
        end

        defer_setup(async(function()
          local read_ok, data = pcall(Path.read, poetry_file)

          if not read_ok then
            vim.notify(
              "Cannot read pyproject.toml!\nlsp will disable poetry support for pyright.",
              vim.log.levels.WARN,
              { title = "lsp" }
            )

            return
          end

          local parse_ok, pyproject = pcall(toml.parse, data)

          if not parse_ok then
            vim.notify(
              "malformed toml format in pyproject.toml!\nlsp will disable poetry support for pyright.",
              vim.log.levels.WARN,
              { title = "lsp" }
            )

            return
          end

          if pyproject.tool == nil or pyproject.tool.poetry == nil then
            return
          end

          local venv_path = vim.trim(vim.fn.system "poetry config virtualenvs.path")
          local venv_directory = vim.trim(vim.fn.system "poetry env list")

          if #vim.split(venv_directory, "\n") == 1 then
            return "poetry", string.format("%s/%s/bin/python", venv_path, vim.split(venv_directory, " ")[1])
          end
        end))
      elseif pipenv_file:is_file() then
        if vim.fn.executable "pipenv" ~= 1 then
          return
        end

        defer_setup(async(function()
          local venv_directory = vim.trim(vim.fn.system "pipenv --venv")

          if venv_directory:match "No virtualenv" ~= nil then
            return
          end

          return "pipenv", venv_directory .. "/bin/python"
        end))
      elseif venv_dir:is_dir() then
        local venv_bin = Path:new(venv_dir:expand() .. "/bin/python")

        if not venv_bin:exists() or vim.fn.executable(venv_bin:expand()) ~= 1 then
          return
        end

        return "venv", venv_bin:expand()
      end
    end

    local name, python_bin = find_python_bin()

    if name == "defer" then
      return
    end

    if name ~= nil then
      opts.settings = {
        python = {
          pythonPath = python_bin,
        },
      }

      CURRENT_VENV = name
    end

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
      importMap = "./import_map.json",
      codeLens = {
        implementations = true,
        references = true,
      },
    }

    opts.settings = {
      deno = opts.init_options,
    }
  end

  if server.name == "sumneko_lua" then
    local lua_dev = require("lua-dev").setup {}

    opts.on_new_config = lua_dev.on_new_config
    opts.settings = lua_dev.settings
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
        data_dir
          .. "/dapinstall/java/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
      ),
    }

    vim.list_extend(bundles, vim.split(vim.fn.glob(data_dir .. "/dapinstall/java/java-test/server/*.jar"), "\n"))

    vim.list_extend(
      bundles,
      vim.split(vim.fn.glob(data_dir .. "/lsp_servers/jdtls/java-decompiler/server/*.jar"), "\n")
    )

    local on_attach = function(client, bufnr)
      require("jdtls").setup_dap { hotcoderplace = "auto" }
      require("lsp").common_on_attach(client, bufnr)
    end

    local extendedClientCapabilities = require("jdtls").extendedClientCapabilities

    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

    require("jdtls").start_or_attach {
      before_init = function()
        vim.notify("Starting eclipse.jdt.ls, this take a while...", vim.log.levels.INFO, { title = "jdtls" })
      end,
      cmd = { config_dir .. "/bin/" .. jdtls_bin },
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
              url = config_dir .. "/lua/lsp/java/styles/" .. O.java.format.name .. ".xml",
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

return { common_on_attach = common_on_attach }
