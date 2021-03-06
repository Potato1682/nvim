local M = {}

local vim = vim

local function hrtime()
  return vim.loop.hrtime() / 1000000000
end

local relative_j_time = hrtime()
local relative_k_time = hrtime()

local press_fre = 0

function M.move_j()
  if vim.v.count > 1 then
    vim.cmd("normal! " .. vim.v.count .. "gj")

    return
  end

  if
    hrtime() - relative_j_time > 0.1
    or hrtime() - relative_j_time < 0.01
  then
    press_fre = 0
  end

  local step = math.floor(press_fre / 5 + 1)

  if step >= 10 then
    step = 10
  end

  relative_j_time = hrtime()
  press_fre = press_fre + 1

  local command

  if step ~= 1 then
    vim.opt_local.relativenumber = false
    vim.opt_local.cursorline = false
    vim.opt_local.cursorcolumn = false

    vim.opt.eventignore = vim.opt.eventignore + { "CursorMoved" }

    if step == 10 then
      command = "normal! " .. step .. "j"
    else
      command = "normal! " .. step .. "gj"
    end
  else
    if O.relative_number and vim.opt_local.buftype:get() ~= "nofile" then
      if not pcall(require, "zen-mode") then
        vim.opt_local.relativenumber = true
      elseif not require("zen-mode.view").is_open() then
        vim.opt_local.relativenumber = true
      end
    end

    vim.opt.eventignore = vim.opt.eventignore - { "CursorMoved" }

    if
      vim.tbl_contains({ "nvimtree", "dashboard", "neogitstatus", "any-jump", "netrw" }, vim.opt_local.filetype:get())
    then
      vim.opt_local.relativenumber = false
    end

    if O.cursorline then
      vim.opt_local.cursorline = true
    end

    if O.cursorcolumn then
      vim.opt_local.cursorcolumn = true
    end

    command = "normal! " .. "gj"
  end

  vim.cmd(command)
end

function M.move_k()
  if vim.v.count > 1 then
    vim.cmd("normal! " .. vim.v.count .. "gk")

    return
  end

  if
    hrtime() - relative_k_time > 0.1
    or hrtime() - relative_k_time < 0.01
  then
    press_fre = 0
  end

  local step = math.floor(press_fre / 5 + 1)

  if step >= 10 then
    step = 10
  end

  relative_k_time = hrtime()
  press_fre = press_fre + 1

  local command

  if step ~= 1 then
    vim.opt_local.relativenumber = false
    vim.opt_local.cursorline = false
    vim.opt_local.cursorcolumn = false

    vim.opt.eventignore = vim.opt.eventignore + { "CursorMoved" }

    if step == 10 then
      command = "normal! " .. step .. "k"
    else
      command = "normal! " .. step .. "gk"
    end
  else
    if O.relative_number and vim.opt_local.buftype:get() ~= "nofile" then
      if not pcall(require, "zen-mode") then
        vim.opt_local.relativenumber = true
      elseif not require("zen-mode.view").is_open() then
        vim.opt_local.relativenumber = true
      end
    end

    vim.opt.eventignore = vim.opt.eventignore - { "CursorMoved" }

    if
      vim.tbl_contains({ "nvimtree", "dashboard", "neogitstatus", "any-jump", "netrw" }, vim.opt_local.filetype:get())
    then
      vim.opt_local.relativenumber = false
    end

    if O.cursorline then
      vim.opt_local.cursorline = true
    end

    if O.cursorcolumn then
      vim.opt_local.cursorcolumn = true
    end

    command = "normal! " .. "gk"
  end

  vim.cmd(command)
end

return M
