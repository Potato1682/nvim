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

function M.setup()
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
      { "BufReadPost", "*", "lua require'utils.resume'.resume()" },
      { "WinEnter,BufEnter", "*", [[ if luaeval("O.cursorline") | setlocal cursorline | endif ]] },
      { "WinLeave,BufLeave", "*", [[ if luaeval("O.cursorline") | setlocal nocursorline | endif ]] },
      { "WinEnter,BufEnter", "*", [[ if luaeval("O.cursorcolumn") | setlocal cursorcolumn | endif ]] },
      { "WinLeave,BufLeave", "*", [[ if luaeval("O.cursorcolumn") | setlocal nocursorcolumn | endif ]] },
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
    lens = {
      { "BufWinEnter,WinEnter", "*", "silent! call win#lens()" },
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
    lsp = {
      { "CursorMoved,CursorMovedI", "*", "silent! lua vim.lsp.buf.hover()" },
    },
    mkdir = {
      { "BufWritePre", "*", "lua require'utils'.file_mkdirp()" },
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
