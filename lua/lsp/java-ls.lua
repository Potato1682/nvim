if vim.fn.has("mac") == 1 then
  JAVA_LS_EXECUTABLE = 'java-mac-ls'
elseif vim.fn.has("unix") == 1 then
  JAVA_LS_EXECUTABLE = 'java-linux-ls'
else
  print("Java LS: Unsupported system")
end

local bundles = { vim.fn.glob(CONFIG_PATH .. "/./debuggers/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar") }

local on_attach = function()
  require('jdtls').setup_dap()
end

require('jdtls').start_or_attach({
  on_attach = on_attach,
  cmd = { JAVA_LS_EXECUTABLE },
  root_dir = require('jdtls.setup').find_root({ 'build.gradle', 'pom.xml', '.git' }),
  init_options = { bundles = bundles }
})

