local M = {}

local windows = require "modules.windows"

local pos = {}
local api = vim.api

local function apply_action_keys()
  local quit_key = "<esc>"
  local exec_key = "<cr>"

  vim.api.nvim_buf_set_keymap(
    0,
    "i",
    exec_key,
    "<cmd>lua require'lsp.rename'.do_rename()<cr>",
    { noremap = true, nowait = true, silent = true }
  )

  if type(quit_key) == "table" then
    for _, k in ipairs(quit_key) do
      vim.api.nvim_buf_set_keymap(
        0,
        "i",
        k,
        "<cmd>lua require'lsp.rename'.close_rename_window()<cr>",
        { noremap = true, nowait = true, silent = true }
      )
    end
  else
    vim.api.nvim_buf_set_keymap(
      0,
      "i",
      quit_key,
      "<cmd>lua require'lsp.rename'.close_rename_window()<cr>",
      { noremap = true, nowait = true, silent = true }
    )
  end

  api.nvim_command "nnoremap <buffer><silent>q <cmd>lua require'lsp.rename'.close_rename_window()<cr>"
end

local unique_name = "textDocument-rename"

function M.close_rename_window()
  if vim.api.nvim_get_mode().mode == "i" then
    vim.cmd [[ stopinsert ]]
  end

  local has, winid = pcall(api.nvim_win_get_var, 0, unique_name)

  if has then
    windows.nvim_close_valid_window(winid)
    api.nvim_win_set_cursor(0, pos)

    pos = {}
  end
end

function M.do_rename()
  local prompt_prefix = "❯ "
  local new_name = vim.trim(vim.api.nvim_get_current_line():sub(#prompt_prefix + 1, -1))

  M.close_rename_window()

  local params = vim.lsp.util.make_position_params()
  local current_name = vim.fn.expand "<cword>"

  if not (new_name and #new_name > 0) or new_name == current_name then
    return
  end

  params.newName = new_name

  vim.lsp.buf_request(0, "textDocument/rename", params)
end

function M.rename()
  local active = require("modules").is_lsp_active()

  if not active then
    return
  end

  M.close_rename_window()

  pos = vim.api.nvim_win_get_cursor(0)

  local opts = {
    height = 1,
    width = 30,
  }

  local content_opts = {
    contents = {},
    filetype = "",
    enter = true,
    highlight = "FloatBorder",
  }

  local bufnr, winid = windows.create_window(content_opts, opts)
  local rename_prompt_prefix = api.nvim_create_namespace "rename_prompt_prefix"

  vim.wo[winid].scrolloff = 0
  vim.wo[winid].sidescrolloff = 0

  vim.bo[bufnr].modifiable = true

  local prompt_prefix = "❯ "

  vim.bo[bufnr].buftype = "prompt"

  vim.fn.prompt_setprompt(bufnr, prompt_prefix)
  api.nvim_buf_add_highlight(bufnr, rename_prompt_prefix, "Blue", 0, 0, #prompt_prefix)

  vim.cmd [[ startinsert! ]]

  api.nvim_win_set_var(0, unique_name, winid)

  require("events").nvim_create_autocmd {
    "QuitPre",
    "<buffer>",
    "++nested",
    "++once",
    ":silent lua require'lsp.rename'.close_rename_window()",
  }

  apply_action_keys()
end

return M
