vim.o.completeopt = "menuone,noselect"

require("compe").setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = "enable",
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,

  source = {
    path = { kind = "  " },
    buffer = { kind = "  " },
    calc = { kind = "  " },
    vsnip = { kind = "  " },
    nvim_lsp = { kind = "  " },
    nvim_lua = { kind = "  " },
    spell = { kind = "  " },
    tags = false,
    vim_dadbod_completion = true,
    tabnine = true,
    emoji = { kind = " ﲃ ", filetypes = { "markdown" } },
  },
}

local npairs = require "nvim-autopairs"
local indent = require "nvim-treesitter.indent"

_G.MUtils = {}

vim.g.completion_confirm_key = ""

function _G.MUtils.enter_confirm()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info()["selected"] ~= -1 then
      if vim.fn.call("vsnip#available", { 1 }) == 1 then
        return npairs.esc("<Plug>(vsnip-expand-or-jump)")
      end

      return vim.fn["compe#confirm"](npairs.esc("<cr>"))
    else
      vim.defer_fn(function()
        require("nvim-autospace").format(-1)
      end, 20)

      return npairs.esc("<cr>")
    end
  else
    vim.defer_fn(function()
      require("nvim-autospace").format(-1)
    end, 20)

    return npairs.autopairs_cr()
  end
end

function _G.MUtils.tab_complete()
  if vim.fn.pumvisible() == 1 then
    return npairs.esc "<C-n>"
  else
    if vim.fn.call("vsnip#jumpable", { 1 }) == 1 then
      return npairs.esc("<Plug>(vsnip-jump-next)")
    else
      local line = vim.fn.getline "."

      if line == "" then
        local indent_number = indent.get_indent(vim.api.nvim_win_get_cursor(0)[1])

        if indent_number == 0 then
          indent_number = 2 * (vim.bo.expandtab and 1 or 2)
        end

        if not vim.bo.expandtab then
          return npairs.esc(string.rep("<Tab>", indent_number))
        end

        return string.rep(" ", indent_number)
      else
        return npairs.esc "<Tab>"
      end
    end
  end
end

function _G.MUtils.s_tab_complete()
  if vim.fn.pumvisible() == 1 then
    return npairs.esc "<C-p>"
  else
    if vim.fn.call("vsnip#jumpable", { -1 }) == 1 then
      return npairs.esc("<Plug>(vsnip-jump-prev)")
    else
      return npairs.esc "<C-h>"
    end
  end
end

vim.api.nvim_set_keymap("i", "<cr>", "v:lua.MUtils.enter_confirm()", { expr = true })

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.MUtils.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.MUtils.tab_complete()", { expr = true })

vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.MUtils.s_tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.MUtils.s_tab_complete()", { expr = true })
