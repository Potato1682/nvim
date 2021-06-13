require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = { enable = true },
  matchup = { enable = true },
  indent = { enable = { "javascriptreact", "typescriptreact" } },
  autotag = { enable = true },
  rainbow = { enable = true },
  context_commentstring = { enable = true, enable_autocmd = true },
  node_movement = {
    keymaps = {
      move_up = "<a-k>",
      move_down = "<a-j>",
      move_left = "<a-h>",
      move_right = "<a-l>",
      swap_left = "<s-a-h>",
      swap_right = "<s-a-l>",
      select_current_node = "<leader><Cr>"
    },
    swappable_textobjects = { "@function.outer", "@parameter.inner", "@statement.outer" },
    allow_switch_parents = true,
    allow_next_parent = true
  }
}

