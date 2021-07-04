local config = require "kommentary.config"

config.configure_language("javascriptreact", {
  hook_function = function()
    require("ts_context_commentstring.internal").update_commentstring()
  end,
})

config.configure_language("javascript.jsx", {
  hook_function = function()
    require("ts_context_commentstring.internal").update_commentstring()
  end,
})

config.configure_language("typescriptreact", {
  hook_function = function()
    require("ts_context_commentstring.internal").update_commentstring()
  end,
})

config.configure_language("typescript.tsx", {
  hook_function = function()
    require("ts_context_commentstring.internal").update_commentstring()
  end,
})

config.configure_language("vue", {
  hook_function = function()
    require("ts_context_commentstring.internal").update_commentstring()
  end,
})
