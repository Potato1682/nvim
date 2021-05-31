local mono = vim.fn.stdpath("data") .. "/lspinstall/csharp/omnisharp/bin/mono"
local bin = vim.fn.stdpath("data") .. "/lspinstall/csharp/omnisharp/omnisharp/OmniSharp.exe"

if vim.fn.filereadable(bin) == 0 then require("lspinstall").install_server("csharp") end

local pid = vim.fn.getpid()

require'lspconfig'.omnisharp.setup { cmd = mono, bin, "--languageserver", "--hostPID", tostring(pid) }

