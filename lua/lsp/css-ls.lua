require'lspconfig'.cssls.setup {
    cmd = {
        "node", "/usr/lib/node_modules/vscode-css-languageserver-bin/cssServerMain.js",
        "--stdio"
    },
    on_attach = require'lsp'.common_on_attach
}

