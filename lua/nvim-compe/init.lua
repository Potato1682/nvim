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
  max_menu_width = 80,
  documentation = {
    border = { "", "", "", " ", "", "", "", " " },
    max_height = math.floor(vim.o.lines * 0.3),
  },

  source = {
    path = { kind = " " },
    buffer = { kind = " " },
    calc = { kind = " " },
    luasnip = { kind = " " },
    nvim_lsp = { kind = " " },
    nvim_lua = { kind = " " },
    spell = { kind = " " },
    tags = false,
    vim_dadbod_completion = { kind = " " },
    tabnine = true,
    emoji = { kind = "ﲃ ", filetypes = { "markdown" } },
  },
}

require("nvim-autopairs.completion.compe").setup {
  map_cr = false,
  map_complete = true,
}

local luasnip = require "luasnip"
local npairs = require "nvim-autopairs"
local t = npairs.esc

_G.MUtils = {}

function _G.MUtils.enter_confirm()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info()["selected"] ~= -1 then
      return vim.fn["compe#confirm"] { keys = "<cr>", select = true }
    else
      vim.defer_fn(function()
        require("nvim-autospace").format(-1)
      end, 20)

      return t "<cr>"
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
    return t "<C-n>"
  else
    if luasnip.jumpable(1) then
      luasnip.jump(1)

      return ""
    else
      return require("modules.indent").smart_indent()
    end
  end
end

function _G.MUtils.s_tab_complete()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    if luasnip.jumpable(-1) then
      luasnip.jump(-1)

      return ""
    else
      return t "<C-h>"
    end
  end
end

function _G.MUtils.snip_next()
  if luasnip.jumpable(1) then
    luasnip.jump(1)
  end

  return ""
end

function _G.MUtils.snip_prev()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end

  return ""
end

function _G.MUtils.close_or_choice()
  if luasnip.choice_active() then
    luasnip.change_choice(1)
  else
    vim.fn["compe#close"]()
  end
end

vim.api.nvim_set_keymap("i", "<cr>", "v:lua.MUtils.enter_confirm()", { expr = true })

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.MUtils.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.MUtils.s_tab_complete()", { expr = true })

vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.MUtils.snip_next()", { expr = true })
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.MUtils.snip_prev()", { expr = true })

vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-e>", "<cmd>call v:lua.MUtils.close_or_choice()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("s", "<C-e>", "<cmd>call v:lua.MUtils.close_or_choice()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-f>", "compe#scroll({ 'delta': +4 })", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-d>", "compe#scroll({ 'delta': -4 })", { noremap = true, expr = true, silent = true })
