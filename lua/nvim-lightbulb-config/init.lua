vim.cmd [[ hi link LightBulbVirtualText Green ]]
vim.cmd [[ autocmd CursorHold,CursorHoldI * lua require"nvim-lightbulb".update_lightbulb({ sign = { enabled = false }, virtual_text = { enabled = true, text = " " }, status_text = { enabled = true, text = " " }}) ]]
