require("gitsigns").setup {
  signs = {
    add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },
  signcolumn = true,
  numhl = false,
  linehl = false,
  word_diff = false,
  keymaps = {
    noremap = true,
    buffer = true,

    ["n ]c"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<cr>'" },
    ["n [c"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<cr>'" },
    ["n <leader>gj"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<cr>'" },
    ["n <leader>gk"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<cr>'" },

    ["n <leader>gs"] = "<cmd>lua require'gitsigns'.stage_hunk()<cr>",
    ["v <leader>gs"] = "<cmd>lua require'gitsigns'.stage_hunk { vim.fn.line('.'), vim.fn.line('v') }<cr>",
    ["n <leader>gu"] = "<cmd>lua require'gitsigns'.undo_stage_hunk()<cr>",
    ["n <leader>gr"] = "<cmd>lua require'gitsigns'.reset_hunk()<cr>",
    ["v <leader>gr"] = "<cmd>lua require'gitsigns'.reset_hunk { vim.fn.line('.'), vim.fn.line('v') }<cr>",
    ["n <leader>gR"] = "<cmd>lua require'gitsigns'.reset_buffer()<cr>",
    ["n <leader>gp"] = "<cmd>lua require'gitsigns'.preview_hunk()<cr>",

    ["o ih"] = ":<C-U>lua require'gitsigns.actions'.select_hunk()<cr>",
    ["x ih"] = ":<C-U>lua require'gitsigns.actions'.select_hunk()<cr>",
  },
  preview_config = {
    border = "none",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  watch_index = {
    interval = 1000,
    follow_files = true,
  },
  diff_opts = {
    algorithm = "histogram",
    internal = true,
  },
  attach_to_untracked = true,
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "right_align",
    delay = 400,
  },
  current_line_blame_formatter_opts = {
    relative_time = true,
  },
  yadm = {
    enable = O.yadm.enabled,
  },
}

vim.cmd [[ hi link GitSignsCurrentLineBlame Comment ]]
