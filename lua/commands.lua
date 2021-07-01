local utils = require "utils"

utils.define_command("Reload", "lua require'utils.reload'.reload()", {})
utils.define_command("Restart", "lua requie'utils.restart'.restart()", {})

