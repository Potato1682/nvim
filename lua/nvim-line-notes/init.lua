require("line-notes").setup {
  path = vim.fn.stdpath "data" .. "/line-notes.json", -- path where to save the file
  border_style = "rounded",
  preview_max_width = 80, -- maximum width of preview notes float window
  auto_preview = false,
  icon = require("nvim-nonicons").get "comment",
  mappings = {
    add = "gla",
    edit = "gle",
    preview = "glp",
    delete = "gld",
  },
}
