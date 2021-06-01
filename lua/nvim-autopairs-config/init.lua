local npairs = require("nvim-autopairs")
local endwise = require('nvim-autopairs.ts-rule').endwise

npairs.add_rules({ endwise('then$', 'end', 'lua', 'if_statement') })

