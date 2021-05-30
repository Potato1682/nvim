local config = require'lspconfig'.jdtls.document_config

require'lspconfig/configs'.jdtls = nil

require'lspinstall/servers'.jdtls = vim.tbl_extend('error', config, {
  install_script = [[
    git clone https://github.com/eclipse/eclipse.jdt.ls.git
    cd eclipse.jdt.ls
    ./mvnw clean verify
  ]],
  uninstall_script = nil
})

require'lspinstall'.setup()

