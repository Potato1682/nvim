local M = {}

local api = vim.api

function M.win_enter()
  if O.cursorline then
    vim.opt_local.cursorline = true
  end

  if O.cursorcolumn then
    vim.opt_local.cursorcolumn = true
  end

  if vim.opt_local.buftype:get() ~= "" then
    return
  end

  if
    vim.tbl_contains(
      {
        "man",
        "help",
        "nvimtree",
        "dashboard",
        "NeogitStatus",
        "terminal",
        "toggleterm",
        "docker-tools-container",
        "netrw",
      },
      vim.opt_local.filetype:get()
    )
  then
    vim.opt.spell = false

    return
  end

  vim.opt.spell = true
  vim.opt.spelllang = { "en", "cjk" }

  require "nvim-spell"
  require("spellsitter").mod_spell_opt()
end

function M.win_leave()
  if O.cursorline then
    vim.opt_local.cursorline = false
  end

  if O.cursorcolumn then
    vim.opt_local.cursorcolumn = false
  end

  if vim.opt_local.buftype:get() ~= "" then
    return
  end

  vim.opt.spell = false
end

function M.nvim_close_valid_window(winid)
  local close_win = function(win_id)
    if win_id == 0 then
      return
    end

    if vim.api.nvim_win_is_valid(win_id) then
      api.nvim_win_close(win_id, true)
    end
  end

  local _switch = {
    ["table"] = function()
      for _, id in ipairs(winid) do
        close_win(id)
      end
    end,
    ["number"] = function()
      close_win(winid)
    end,
  }

  local _switch_metatable = {
    __index = function(_, t)
      error(string.format("Wrong type %s of winid", t))
    end,
  }

  setmetatable(_switch, _switch_metatable)

  _switch[type(winid)]()
end

local function make_floating_popup_options(width, height, opts)
  vim.validate {
    opts = { opts, "t", true },
  }

  opts = opts or {}

  vim.validate {
    ["opts.offset_x"] = { opts.offset_x, "n", true },
    ["opts.offset_y"] = { opts.offset_y, "n", true },
  }
  local new_option = {}

  new_option.style = "minimal"
  new_option.width = width
  new_option.height = height

  if opts.relative ~= nil then
    new_option.relative = opts.relative
  else
    new_option.relative = "cursor"
  end

  if opts.anchor ~= nil then
    new_option.anchor = opts.anchor
  end

  if opts.row == nil and opts.col == nil then
    local lines_above = vim.fn.winline() - 1
    local lines_below = vim.fn.winheight(0) - lines_above

    new_option.anchor = ""

    local pum_pos = vim.fn.pum_getpos()
    local pum_vis = not vim.tbl_isempty(pum_pos)

    if pum_vis and vim.fn.line "." >= pum_pos.row or not pum_vis and lines_above < lines_below then
      new_option.anchor = "N"
      new_option.row = 1
    else
      new_option.anchor = "S"
      new_option.row = -2
    end

    if vim.fn.wincol() + width <= vim.opt.columns:get() then
      new_option.anchor = new_option.anchor .. "W"

      new_option.col = 0
    else
      new_option.anchor = new_option.anchor .. "E"

      new_option.col = 1
    end
  else
    new_option.row = opts.row
    new_option.col = opts.col
  end

  return new_option
end

local function generate_win_opts(contents, opts)
  opts = opts or {}

  local win_width, win_height = vim.lsp.util._make_floating_popup_size(contents, opts)

  opts = make_floating_popup_options(win_width, win_height, opts)

  return opts
end

function M.create_window(content_opts, opts)
  vim.validate {
    content_opts = { content_opts, "t" },
    contents = { content_opts.content, "t", true },
    opts = { opts, "t", true },
  }

  local contents, filetype = content_opts.contents, content_opts.filetype
  local enter = content_opts.enter or false

  opts = opts or {}
  opts = generate_win_opts(contents, opts)
  opts.border = "none"

  local bufnr = api.nvim_create_buf(false, true)
  local content = vim.lsp.util._trim(contents)

  if filetype then
    vim.bo[bufnr].filetype = filetype
  end

  api.nvim_buf_set_lines(bufnr, 0, -1, true, content)

  vim.bo[bufnr].modifiable = false
  vim.bo[bufnr].bufhidden = "wipe"
  vim.bo[bufnr].buftype = "nofile"

  local winid = api.nvim_open_win(bufnr, enter, opts)

  if filetype == "markdown" then
    vim.wo[winid].conceallevel = 2
  end

  vim.wo[winid].winblend = 13
  vim.wo[winid].foldlevel = 100

  return bufnr, winid
end

return M
