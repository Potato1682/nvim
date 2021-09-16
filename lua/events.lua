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

    vim.g.cursorhold_timer_id = vim.fn.timer_start(1100, "CursorHold_Callback")
  end
end

function M.cursorhold_insert_timer()
  vim.fn.timer_stop(vim.g.cursorhold_timer_id)

  vim.g.cursorhold_timer_id = vim.fn.timer_start(1100, "CursorHoldI_Callback")
end

function M.setup()
  if vim.g.loaded_events then
    return
  end

  vim.g.cursorhold_timer_id = -1

  -- CursorHold fixes
  vim.opt.eventignore = vim.opt.eventignore + { "CursorHold", "CursorHoldI" }

  vim.cmd("source " .. config_dir .. "/vim/cursor-hold.vim")

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
      { "BufEnter", "*", "if luaeval('not not _G.MPairs') | imap <silent> <BS> <cmd>call v:lua.MPairs.check_bs()<cr>| endif" },
    },
    cursor = {
      { "WinEnter,BufEnter", "*", "lua require'modules.windows'.win_enter()" },
      { "WinLeave,BufLeave", "*", "lua require'modules.windows'.win_leave()" },
    },
    dashboard = {
      {
        "FileType",
        "dashboard",
        "setlocal" .. table.concat(
          vim.split(
            [[
              nocursorline
              noswapfile
              synmaxcol&
              signcolumn=no
              norelativenumber
              nocursorcolumn
              nospell
              nolist
              nonumber
              bufhidden=wipe
              colorcolumn=
              foldcolumn=0
              matchpairs=
              laststatus=0
              showtabline=0
            ]],
            "\n"
          ),
          " "
        ),
      },
      { "FileType", "dashboard", "nnoremap <silent> <buffer> q :q<cr>" },
    },
    auto_compile = {
      { "BufWritePost", "plugins.lua", "source <afile> | PackerCompile" }
    },
    bufs = {
      { "BufWritePost", "COMMIT_EDITMSG", "setlocal noundofile" },
      { "BufWritePost,FileWritePost", "*.vim", "nested", [[if &l:autoread > 0 | source <afile> | echo 'source ' . bufname('%') | endif]] },
      { "BufWritePre", "/tmp/*", "setlocal noundofile" },
      { "BufWritePre", "COMMIT_EDITMSG", "setlocal noundofile" },
      { "BufWritePre", "MERGE_MSG", "setlocal noundofile" },
      { "BufWritePre", "*.tmp", "setlocal noundofile" },
      { "BufWritePre", "*.tmp", "setlocal noundofile" },
      { "BufWritePre", "*.tmp", "setlocal noundofile" },
      { "BufWritePre", "*.log", "setlocal noundofile" },
      { "BufWritePre", "*.bak", "setlocal noundofile" },
    },
    format = {
      { "BufWritePost", "*", "Format!" },
    },
    history = {
      { "CmdlineEnter", ":", "lua require'modules.cmd-history'.clean()" },
    },
    mkdir = {
      { "BufWritePre", "*", "lua require'modules'.file_mkdirp()" },
    },
    ime = {
      { "InsertLeave", "*", "lua require'modules.ime'.ime_disable()" },
    },
    resume = {
      { "BufReadPost", "*", "lua require'modules.resume'.resume_buf()" },
      { "FileType", "*", "lua require'modules.resume'.resume_ft()" },
    },
    spaces = {
      { "BufRead,BufNew", "*", "lua require'modules.spaces'.highlight_japanese_spaces()" },
      { "InsertEnter", "*", "lua require'modules.spaces'.highlight_trailing_spaces()" },
      { "InsertLeave", "*", "lua require'modules.spaces'.highlight_insert_trailing_spaces()" },
      { "BufWritePre", "*", "lua require'modules.spaces'.strip_trailing_spaces()" },
    },
    wins = {
      { "FocusLost", "*", "noautocmd silent! wa" },
      { "VimEnter", "*", "lua require'events'.on_enter()" },
      { "ColorScheme", "*", "lua require'events'.on_color()" },
      { "VimResized", "*", "tabdo wincmd =" },
      { "VimLeave", "*", "wshada!" },
      { "FocusGained", "*", "checktime" },
    },
    yank = {
      { "TextYankPost", "*", [[silent! lua vim.highlight.on_yank { higroup = "IncSearch", timeout = 400 }]] },
    },
  }

  M.nvim_create_augroups(definitions)

  if O.relative_number then
    M.nvim_create_augroups {
      relativenumber = {
        {
          "BufEnter,FocusGained,InsertLeave,WinEnter",
          "*",
          "if &number && mode() != 'i' | set relativenumber | endif",
        },
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
end

M.setup()

return M
