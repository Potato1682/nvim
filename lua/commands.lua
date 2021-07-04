local utils = require "nvim-utils"

utils.define_command("Reload", "lua require'nvim-utils.reload'.reload()", {})
utils.define_command("Restart", "lua requie'nvim-utils.restart'.restart()", {})
