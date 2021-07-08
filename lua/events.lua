local vim = vim
local M = {}

function M.nvim_create_autocmd(definition)
  if type(definition[1]) == "table" then
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten { "autocmd", def }, " ")

      vim.api.nvim_command(command)
    end
  else
    local command = table.concat(vim.tbl_flatten { "autocmd", definition }, " ")

    vim.api.nvim_command(command)
  end
end

function M.nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command("augroup " .. group_name)
    vim.api.nvim_command "autocmd!"

    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten { "autocmd", def }, " ")

      vim.api.nvim_command(command)
    end

    vim.api.nvim_command "augroup END"
  end
end

function M.cursorhold_timer()
  if vim.fn.mode() == "n" then
    vim.fn.timer_stop(vim.g.cursorhold_timer_id)

    vim.g.cursorhold_timer_id = vim.fn.timer_start(1500, "CursorHold_Callback")
  end
end

function M.cursorhold_insert_timer()
  vim.fn.timer_stop(vim.g.cursorhold_timer_id)

  vim.g.cursorhold_timer_id = vim.fn.timer_start(1500, "CursorHoldI_Callback")
end

function M.setup()
  if vim.g.loaded_events then
    return
  end

  vim.g.cursorhold_timer_id = -1

  -- CursorHold fixes
  if vim.opt.eventignore._value == nil or vim.opt.eventignore._value == "" then
    vim.opt.eventignore = "CursorHold,CursorHoldI"
  else
    vim.opt.eventignore = vim.opt.eventignore._value .. ",CursorHold,CursorHoldI"
  end

  vim.cmd("source " .. vim.fn.stdpath "config" .. "/vim/cursor-hold.vim")

  M.nvim_create_augroups {
    cursorhold_fix = {
      { "CursorMoved", "*", "lua require'events'.cursorhold_timer()" },
      { "CursorMovedI", "*", "lua require'events'.cursorhold_insert_timer()" },
    },
  }

  local definitions = {
    comment = {
      { "BufEnter", "*", "setlocal formatoptions-=r" },
      { "BufEnter", "*", "setlocal formatoptions-=o" },
    },
    backspace = {
      { "BufEnter", "*", "silent! iunmap <buffer> <BS>" },
      { "BufEnter", "*", "imap <silent> <bs> <cmd>call v:lua.MPairs.check_bs()<cr>" },
    },
    cursor = {
      { "BufReadPost", "*", "lua require'nvim-utils.resume'.resume()" },
      { "WinEnter,BufEnter", "*", "lua require'nvim-utils.windows'.win_enter()" },
      { "WinLeave,BufLeave", "*", "lua require'nvim-utils.windows'.win_leave()" },
    },
    dashboard = {
      {
        "FileType",
        "dashboard",
        "setlocal nocursorline noswapfile synmaxcol& signcolumn=no norelativenumber nocursorcolumn nospell nolist nonumber bufhidden=wipe colorcolumn= foldcolumn=0 matchpairs= ",
      },
      { "FileType", "dashboard", "set showtabline=0 | autocmd BufLeave <buffer> set showtabline=2" },
      { "FileType", "dashboard", "nnoremap <silent> <buffer> q :q<cr>" },
    },
    bufs = {
      { "BufWritePre", "*.tmp", "setlocal noundofile" },
      { "BufWritePre", "*.log", "setlocal noundofile" },
      { "BufWritePre", "*.bak", "setlocal noundofile" },
    },
    format = {
      { "BufWritePost", "*", "lua vim.lsp.buf.formatting()" },
      { "BufWritePre", "*", "undojoin | Neoformat" },
    },
    history = {
      { "CmdlineEnter", ":", "lua require'nvim-utils.cmd-history'.clean()" },
    },
    lsp = {
      { "CursorHold,CursorHoldI", "*", "silent! lua vim.lsp.buf.hover()" },
    },
    mkdir = {
      { "BufWritePre", "*", "lua require'nvim-utils'.file_mkdirp()" },
    },
    ime = {
      { "InsertLeave", "*", "lua require'nvim-utils.ime'.ime_disable()" },
    },
    spaces = {
      { "BufRead,BufNew", "*", "lua require'nvim-utils.spaces'.highlight_japanese_spaces()" },
      { "InsertEnter", "*", "lua require'nvim-utils.spaces'.highlight_trailing_spaces()" },
      { "InsertLeave", "*", "lua require'nvim-utils.spaces'.highlight_insert_trailing_spaces()" },
      { "BufWritePre", "*", "lua require'nvim-utils.spaces'.strip_trailing_spaces()" },
    },
    wins = {
      { "FocusLost", "*", "noautocmd silent! wa" },
      { "VimEnter", "*", "lua require'events'.on_enter()" },
      { "ColorScheme", "*", "lua require'events'.on_color()" },
    },
    yank = {
      { "TextYankPost", [[* silent! lua vim.highlight.on_yank({ higroup="IncSearch", timeout=400 })]] },
    },
  }

  M.nvim_create_augroups(definitions)

  if O.relative_number then
    M.nvim_create_augroups {
      relativenumber = {
        { "BufEnter,FocusGained,InsertLeave,WinEnter", "*", "if &number && mode() != 'i' | set relativenumber | endif" },
        {
          "BufLeave,FocusLost,InsertEnter,WinLeave",
          "*",
          "if &number | set norelativenumber | endif",
        },
      },
    }
  end

  vim.g.loaded_events = true
end

O.enter_event = O.enter_event or {}
O.color_event = O.color_event or {}

function M.add_autocmd_enter(name, func)
  O.enter_event[name] = func
end

function M.on_enter()
  for _, handler in pairs(O.enter_event) do
    handler()
  end
end

function M.add_autocmd_color(name, func, add_to_enter)
  O.color_event[name] = func
  if add_to_enter then
    O.enter_event[name] = func
  end
end

function M.on_color()
  for _, handler in pairs(O.color_event) do
    handler()
  end

  vim.cmd "hi GreenSign ctermbg=235 guibg=#2b2d3a"
  vim.cmd "hi BlueSign ctermbg=235 guibg=#2b2d3a"
  vim.cmd "hi YellowSign ctermbg=235 guibg=#2b2d3a"
  vim.cmd "hi RedSign ctermbg=235 guibg=#2b2d3a"
  vim.cmd "hi! ExtraWhitespace ctermfg=246 guifg=#7e8294 ctermbg=52 guibg=#b30000 cterm=NONE gui=NONE guisp=NONE"
  vim.cmd "hi jsonBoolean ctermfg=107 guifg=#a0c980"
  vim.cmd "hi link NvimTreeLspDiagnosticsError RedSign"
  vim.cmd "hi link NvimTreeLspDiagnosticsWarning YellowSign"
  vim.cmd "hi link NvimTreeLspDiagnosticsInformation BlueSign"
  vim.cmd "hi link NvimTreeLspDiagnosticsHint GreenSign"
  vim.cmd "hi! IndentBlanklineContextChar guifg=#3d8cf0 guibg=NONE gui=nocombine"
  vim.cmd "hi! IndentRainbow1 guifg=#be5046 guibg=NONE gui=nocombine"
  vim.cmd "hi! IndentRainbow2 guifg=#e5c07b guibg=NONE gui=nocombine"
  vim.cmd "hi! IndentRainbow3 guifg=#98c379 guibg=NONE gui=nocombine"
  vim.cmd "hi! IndentRainbow4 guifg=#56b6c2 guibg=NONE gui=nocombine"
  vim.cmd "hi! IndentRainbow5 guifg=#61afef guibg=NONE gui=nocombine"
  vim.cmd "hi! IndentRainbow6 guifg=#c678dd guibg=NONE gui=nocombine"
end

M.setup()

return M
