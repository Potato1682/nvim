if vim.fn.has "mac" == 1 then
  JAVA_LS_EXECUTABLE = "java-mac-ls"
elseif vim.fn.has "unix" == 1 then
  JAVA_LS_EXECUTABLE = "java-linux-ls"
else
  print "[jdtls] Unsupported system"
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
  vim.split(vim.fn.glob(vim.fn.stdpath "data" .. "/lspinstall/jdtls/java-decompiler/server/*.jar"), "\n")
)

local on_attach = function(client)
  require("jdtls").setup_dap { hotcoderplace = "auto" }
  require("lsp").common_on_attach(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.workspace = capabilities.workspace or {}
capabilities.workspace.configuration = true

capabilities.textDocument.completion.completionItem.snippetSupport = true

capabilities.window = capabilities.window or {}
capabilities.window.workDoneProgress = true

local extendedClientCapabilities = require("jdtls").extendedClientCapabilities

extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

if vim.bo.filetype == "java" then
  require("jdtls").start_or_attach {
    before_init = function()
      print "[jdtls] Starting, please wait..."
    end,
    cmd = { vim.fn.stdpath "config" .. "/bin/" .. JAVA_LS_EXECUTABLE },
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
            "/**/test/**",
          },
        },
      },
    },
  }
end
