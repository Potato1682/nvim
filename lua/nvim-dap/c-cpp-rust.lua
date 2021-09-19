local dap = require "dap"

dap.adapters.cpp = {
  type = "executable",
  name = "cppdbg",
  command = vim.api.nvim_get_runtime_file("gadgets/linux/vscode-cpptools/debugAdapters/OpenDebugAD7", false)[1],
  args = {},
  attach = { pidProperty = "processId", pidSelect = "ask" },
}

local M = {}
local last_gdb_config

M.start_c_debugger = function(args, mi_mode, mi_debugger_path)
  if args and #args > 0 then
    last_gdb_config = {
      type = "cpp",
      name = args[1],
      request = "launch",
      program = table.remove(args, 1),
      args = args,
      cwd = vim.loop.cwd(),
      env = { "VAR1=value1", "VAR2=value" }, -- environment variables are set via `ENV_VAR_NAME=value` pairs
      externalConsole = true,
      MIMode = mi_mode or "gdb",
      MIDebuggerPath = mi_debugger_path,
    }
  end

  if not last_gdb_config then
    print 'No binary to debug set! Use ":DebugC <binary> <args>" or ":DebugRust <binary> <args>"'
    return
  end

  dap.run(last_gdb_config)
  dap.repl.open()
end

local command = require("modules").define_command

command(
  "DebugC",
  "lua require'nvim-dap.c-cpp-rust'.start_c_debugger({<f-args>}, 'gdb')",
  { nargs = "*", complete = "file" }
)

command(
  "DebugRust",
  "lua require'nvim-dap.c-cpp-rust'.start_c_debugger({<f-args>}, 'gdb', 'rust-gdb')",
  { nargs = "*", complete = "file" }
)

-- Export module to use this by the commands' function call
return M
