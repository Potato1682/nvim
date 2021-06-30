local config = require("lspconfig").jdtls.document_config

require("lspconfig/configs").jdtls = nil

require("lspinstall/servers").jdtls = vim.tbl_extend("error", config, {
  install_script = [[
    rm -rf eclipse.jdt.ls
    git clone https://github.com/eclipse/eclipse.jdt.ls.git --depth 1 --recursive
    cd eclipse.jdt.ls
    mkdir - pv lombok
    curl -fLo lombok/lombok.jar https://projectlombok.org/downloads/lombok.jar
    ./mvnw clean verify - DskipTests
    cd ..
    git clone https://github.com/dgileadi/vscode-java-decompiler --depth 1 --recursive java-decompiler
  ]],
})

require("lspinstall/servers").eslintd = vim.tbl_extend("error", {}, {
  install_script = [[
    npm install -g eslint_d@latest
  ]],
})

local clangd_config = require("lspinstall/util").extract_config "clangd"

require("lspinstall/servers").cpp = vim.tbl_extend("error", clangd_config, {
  install_script = [[
    os=$(uname -s | tr "[:upper:]" "[:lower:]")
    
    case $os in
      linux)
        platform="linux"
        ;;
      darwin)
        platform="mac"
        ;;
    esac

    curl -Lo clangd.zip $(curl -s "https://api.github.com/repos/clangd/clangd/releases/latest" | jq . | grep -E "https?://.*\.zip" | cut -d\" -f4 | grep "clangd-$platform")
    unzip clangd.zip
    rm clangd.zip
    mv clangd_* clangd
  ]],
})

require("lspinstall/servers")["vscode-servers"] = vim.tbl_extend("error", {}, {
  install_script = [[
    ! test -f package.json && npm init -y --scope=lspinstall || true
    npm install vscode-langservers-extracted@latest
  ]],
})

require("lspinstall/servers").emmet = vim.tbl_extend("error", {}, {
  install_script = [[
    ! test -f package.json && npm init -y --scope=lspinstall || true
    npm install emmet-ls@latest
  ]],
})

require("lspinstall").setup()
