local bin = vim.fn.stdpath("data") .. "/lspinstall/csharp/run"

if vim.fn.filereadable(bin) == 0 then require("lspinstall").install_server("csharp") end

local pid = vim.fn.getpid()

require'lspconfig'.omnisharp.setup { cmd = bin, "--languageserver", "--hostPID", tostring(pid) }

