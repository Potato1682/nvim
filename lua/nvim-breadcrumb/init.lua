local icons = require "nvim-nonicons"

require("nvim-gps").setup {
  icons = {
    ["class-name"] = icons.get "class" .. " ", -- Classes and class-like objects
    ["function-name"] = icons.get "package" .. " ", -- Functions
    ["method-name"] = icons.get "package" .. " ",      -- Methods (functions inside class-like objects)
  },
  languages = { -- You can disable any language individually here
    ["c"] = true,
    ["cpp"] = true,
    ["go"] = true,
    ["java"] = true,
    ["javascript"] = true,
    ["lua"] = true,
    ["python"] = true,
    ["rust"] = true,
  },
  separator = " " .. icons.get "chevron-right" .. " ",
}
