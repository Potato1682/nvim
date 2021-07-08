vim.g.edge_style = O.colorscheme_style
vim.g.edge_enable_italic = 1
vim.g.edge_diagnostic_text_highlight = 0
vim.g.edge_diagnostic_virtual_text = "colored"
vim.g.edge_diagnostic_line_highlight = 1
vim.g.edge_show_eob = 0
vim.g.edge_sign_column_background = "none"
vim.g.edge_better_performance = O.edge_better_performance and 1 or 0
vim.g.edge_cursor = "blue"

vim.cmd("colorscheme " .. O.colorscheme)
