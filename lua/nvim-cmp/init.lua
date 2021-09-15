local cmp = require "cmp"
local luasnip = require "luasnip"
local icons = require "nvim-nonicons"

local function get_icon(name)
  return icons.get(name) .. " "
end

local function t(key)
  return vim.api.nvim_replace_termcodes(key, true, true, true)
end

local function feedkeys(key, mode)
  return vim.api.nvim_feedkeys(t(key), mode, true)
end

local function has_words_before()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end

  local line, col = unpack(vim.api.nvim_win_get_cursor(0))

  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<Tab>"] = cmp.mapping(function(_)
      if vim.fn.pumvisible() == 1 then
        feedkeys("<C-n>", "n")
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        vim.api.nvim_input(require("modules.indent").smart_indent())
      end
    end, {
      "i",
      "s",
    }),
    ["<S-tab>"] = cmp.mapping(function(_)
      if vim.fn.pumvisible() == 1 then
        feedkeys("<C-p>", "n")
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        feedkeys("<BS>", "i")
      end
    end, {
      "i",
      "s",
    }),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
  },
  sources = {
    { name = "tmux" },
    { name = "cmp_tabnine" },
    { name = "path" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = ({
        Text = get_icon "typography",
        Method = get_icon "package-dependencies",
        Function = get_icon "package",
        Constructor = get_icon "package-dependents",
        Field = get_icon "field",
        Variable = "[]",
        Class = get_icon "class",
        Interface = get_icon "interface",
        Module = "{}",
        Property = get_icon "tools",
        Unit = get_icon "beaker",
        Value = " ",
        Enum = get_icon "versions",
        Keyword = get_icon "multi-select",
        Snippet = get_icon "snippet",
        Color = get_icon "paintbrush",
        File = get_icon "file-code",
        Reference = get_icon "file-reference",
        Folder = get_icon "file-directory-outline",
        EnumMember = get_icon "workflow",
        Constant = get_icon "constant",
        Struct = get_icon "struct",
        Event = get_icon "zap",
        Operator = " ",
        TypeParameter = get_icon "type",
      })[vim_item.kind] .. " " .. vim_item.kind

      vim_item.menu = ({
        tmux = get_icon "tmux",
        cmp_tabnine = "<TN>",
        path = get_icon "ellipsis",
        nvim_lsp = get_icon "gear",
        nvim_lua = get_icon "lua",
        luasnip = get_icon "snippet",
        emoji = "ﲃ ",
        vim_dadbod_completion = get_icon "database",
        ["vim-dadbod-completion"] = get_icon "database",
      })[entry.source.name]

      return vim_item
    end,
  },
}

-- Events
local events = require "events"

events.nvim_create_autocmd {
  "FileType",
  "sql,mysql,plsql",
  "lua require'cmp'.setup.buffer { sources = {{ name = 'vim-dadbod-completion' }}}",
}

events.nvim_create_autocmd {
  "FileType",
  "markdown,pandoc.markwdown,rmd",
  "packadd cmp-emoji | lua require'cmp'.setup.buffer { sources = {{ name = 'emoji' }}}",
}
events.nvim_create_autocmd {
  "FileType",
  "lua",
  "packadd cmp-nvim-lua | lua require'cmp'.setup.buffer { sources = {{ name = 'nvim_lua' }}}",
}
