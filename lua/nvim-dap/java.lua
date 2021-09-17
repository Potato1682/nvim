local debug_install_dir = data_dir .. "/dapinstall/java/"

if vim.tbl_isempty(vim.loop.fs_stat(debug_install_dir) or {}) then
  require("nvim-dap.install").install(
    "java debug",
    debug_install_dir,
    [[
    git clone https://github.com/microsoft/java-debug --depth 1 --recursive && cd java-debug
    ./mvnw clean install
  ]]
  )

  require("nvim-dap.install").install(
    "java test runner",
    debug_install_dir,
    [[
    git clone https://github.com/microsoft/vscode-java-test java-test --depth 1 --recursive && cd java-test
    npm i
    npm run build-plugin
  ]]
  )
end
