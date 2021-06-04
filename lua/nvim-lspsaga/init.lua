require("lspsaga").init_lsp_saga { use_saga_diagnostic_sign = true, error_sign = "", warn_sign = "", infor_sign = "", rename_prompt_prefix = ">" }

vim.cmd([[ autocmd CursorHold,CursorHoldI * Lspsaga hover_doc ]])

