local dap = require("dap")

vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })

dap.defaults.fallback.terminal_win_cmd = "50vsplit new"

vim.cmd([[ au FileType dap-repl lua require('dap.ext.autocompl').attach() ]])

vim.g.dap_virtual_text = true

require"dapui".setup()

require"dap.ext.vscode".load_launchjs()

