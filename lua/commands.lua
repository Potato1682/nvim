local modules = require "modules"

modules.define_command("Reload", "lua require'modules.reload'.reload()", {})
modules.define_command("Restart", "lua require'modules.restart'.restart()", {})
modules.define_command(
  "Format",
  "lua require'nvim-formatter.action'.format()",
  { range = true, bang = true, nargs = 0 }
)
modules.define_command("PackerInstall", "packadd packer.nvim | lua require'plugins'.install()", { nargs = 0 })
modules.define_command("PackerUpdate", "packadd packer.nvim | lua require'plugins'.update()", { nargs = 0 })
modules.define_command("PackerSync", "packadd packer.nvim | lua require'plugins'.sync()", { nargs = 0 })
modules.define_command("PackerClean", "packadd packer.nvim | lua require'plugins'.clean()", { nargs = 0 })
modules.define_command("PackerCompile", "packadd packer.nvim | lua require'plugins'.compile(<q-args>)", { nargs = "*" })
modules.define_command("PackerLoad", "packadd packer.nvim | lua require'plugins'.loader(<q-args>)", { nargs = "+" })
modules.define_command("PackerStatus", "packadd packer.nvim | lua require'plugins'.status()", { nargs = 0 })
modules.define_command("PackerProfile", "packadd packer.nvim | lua require'plugins'.profile_output()", { nargs = 0 })
