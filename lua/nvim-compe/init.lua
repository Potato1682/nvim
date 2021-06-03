vim.o.completeopt = "menuone,noselect"

require'compe'.setup {
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
    path = { kind = "  " },
    buffer = { kind = "  " },
    calc = { kind = "  " },
    vsnip = { kind = "  " },
    nvim_lsp = { kind = "  " },
    nvim_lua = { kind = "  " },
    spell = { kind = "  " },
    tags = false,
    vim_dadbod_completion = true,
    tabnine = true,
    emoji = { kind = " ﲃ ", filetypes = { "markdown" } }
  }
}

-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- ﬘
-- 
-- 
-- 
-- m
-- 
-- 
-- 
-- 

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local function check_back_space()
  local col = vim.fn.col(".") - 1

  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local npairs = require("nvim-autopairs")

_G.MUtils = {}

function _G.MUtils.enter_confirm()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.call("vsnip#available", { 1 }) == 1 then
      return t "<Plug>(vsnip-expand-or-jump)"
    elseif vim.fn.complete_info()["selected"] ~= -1 then
      vim.fn["compe#confirm"]()

      return npairs.esc("")
    else
      return npairs.check_break_line_char()
    end
  else
    return npairs.check_break_line_char()
  end
end

function _G.MUtils.tab_complete()
  if vim.fn.pumvisible() == 1 then
    return npairs.esc("<C-n>")
  else
    if vim.fn.call("vsnip#jumpable", { 1 }) == 1 then
      return t "<Plug>(vsnip-jump-next)"
    else
      local line = vim.fn.getline(".")

      if line == "" then
        vim.api.nvim_input("<ESC>s")

        if line == vim.fn.getline(".") then
          if not vim.bo.expandtab then
            return npairs.esc("<Tab>")
          end

          return string.rep(" ", vim.bo.ts + 1)
        end

        return ""
      elseif line:match("^%s$") ~= "" then
        return npairs.esc("<Tab>")
      end
    end
  end
end

function _G.MUtils.s_tab_complete()
  if vim.fn.pumvisible() == 1 then
    return npairs.esc("<C-p>")
  else
    if vim.fn.call("vsnip#jumpable", { -1 }) == 1 then
      return t "<Plug>(vsnip-jump-prev)"
    else
      return npairs.esc("<C-h>")
    end
  end
end

vim.api.nvim_set_keymap("i", "<CR>", "v:lua.MUtils.enter_confirm()", { expr = true })

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.MUtils.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.MUtilstab_complete()", { expr = true })

vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.MUtils.s_tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.MUtils.s_tab_complete()", { expr = true })

