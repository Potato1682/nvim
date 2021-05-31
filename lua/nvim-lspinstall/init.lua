local config = require'lspconfig'.jdtls.document_config

require'lspconfig/configs'.jdtls = nil

require'lspinstall/servers'.jdtls = vim.tbl_extend('error', config, {
  install_script = [[
    rm -rf eclipse.jdt.ls
    git clone https://github.com/eclipse/eclipse.jdt.ls.git
    cd eclipse.jdt.ls
    ./mvnw clean verify -DskipTests
  ]]
})

require'lspinstall/servers'.eslintd = vim.tbl_extend("error", {}, {
  install_script = [[
    ! test -f package.json && npm init -y --scope=lspinstall || true
    npm install eslint_d@latest
  ]]
})

-- Use jq to use collect download url

local lua_config = require("lspinstall/util").extract_config("sumneko_lua")

require("lspinstall/servers").lua = vim.tbl_extend("error", lua_config, {
  install_script = [[
    os=$(uname -s | tr "[:upper:]" "[:lower:]")
    case $os in
      linux)
        platform="Linux"
      ;;
      darwin)
        platform="macOS"
      ;;
    esac

    curl -Lo sumneko-lua.vsix $(curl -s "https://api.github.com/repos/sumneko/vscode-lua/releases/latest" | jq . | grep -E "https?://.*\.vsix" | cut -d : -f 2,3 | tr -d \")
    unzip sumneko-lua.vsix -d sumneko-lua
    rm sumneko-lua.vsix

    chmod +x sumneko-lua/extension/server/bin/$platform/lua-language-server

    echo "#!/usr/bin/env bash" > sumneko-lua-language-server
    echo "\$(dirname \$0)/sumneko-lua/server/bin/$platform/lua-language-server -E -e LANG=en \$(dirname \$0)/sumneko-lua/extension/server/main.lua \$*" >> sumneko-lua-language-server

    chmod +x sumneko-lua-language-server
  ]]
})

local clangd_config = require("lspinstall/util").extract_config("clangd")

require("lspinstall/servers").cpp = vim.tbl_extend('error', clangd_config, {
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
  ]]
})

local omnisharp_config = require("lspinstall/util").extract_config("omnisharp")

require("lspinstall/servers").csharp = vim.tbl_extend("error", omnisharp_config, {
  install_script = [[
    os=$(uname -s | tr "[:upper:]" "[:lower:]")

    case $os in
      linux)
        platform="linux-x64"
        ;;
      darwin)
        platform="osx"
        ;;
    esac
    
    curl -Lo omnisharp.zip $(curl -s https://api.github.com/repos/OmniSharp/omnisharp-roslyn/releases/latest | jq . | grep -E "browser_.+" | cut -d'"' -f4 | grep "omnisharp-$platform.zip")
    unzip omnisharp.zip -d omnisharp
    rm omnisharp.zip
    chmod +x omnisharp/run
  ]]
})

require'lspinstall'.setup()

