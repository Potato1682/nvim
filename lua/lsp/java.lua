if vim.fn.has("mac") == 1 then
  JAVA_LS_EXECUTABLE = 'java-mac-ls'
elseif vim.fn.has("unix") == 1 then
  JAVA_LS_EXECUTABLE = 'java-linux-ls'
else
  print("Java LS: Unsupported system")
end

local bundles = {
  vim.fn.glob(vim.fn.stdpath("data") .. "/dapinstall/java/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar")
}

vim.list_extend(bundles, vim.split(vim.fn.glob(vim.fn.stdpath("data") .. "/dapinstall/java/java-test/server/*.jar"), "\n"))

local on_attach = function(client)
  require"jdtls".setup_dap({ hotcoderplace = "auto" })
  require"lsp".common_on_attach(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.window = capabilities.window or {}
capabilities.window.workDoneProgress = true

if vim.bo.filetype == "java" then
  require('jdtls').start_or_attach({
    cmd = { vim.fn.stdpath("config") .. "/bin/" .. JAVA_LS_EXECUTABLE },
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = require('jdtls.setup').find_root({ 'build.gradle', 'pom.xml', '.git' }),
    init_options = { bundles = bundles }
  })
end

