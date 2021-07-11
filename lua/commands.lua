local modules = require "modules"

modules.define_command("Reload", "lua require'modules.reload'.reload()", {})
modules.define_command("Restart", "lua require'modules.restart'.restart()", {})
