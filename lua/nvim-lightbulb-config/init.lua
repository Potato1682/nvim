vim.cmd(
    [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb({ sign = { enabled = false, priority = 10, text = "" }, float = { enabled = true, text = "", win_opts = {} }, virtual_text = { enabled = false, text = "" }})]])
