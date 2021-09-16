local Path = require "plenary.path"

local function install(name, dir, script)
  if type(dir) == "string" then
    dir = Path:new(dir)
  end

  dir:mkdir({ parents = true, exists_ok = true })

  local function on_exit(_, code)
    if code ~= 0 then
      vim.notify("Could not install " .. name .. "!", "error", { title = "fmtinstall" })
    end

    vim.notify("Successfully installed " .. name .. "!", "success", { title = "fmtinstall" })
  end

  local bufnr = vim.api.nvim_create_buf(false, false)

  if bufnr == 0 then
    vim.notify("Cannot create installer buffer!", "error", { title = "fmtinstall" })

    return
  end

  vim.cmd "botright split new"

  vim.api.nvim_win_set_height(0, 15)

  local bufnr = vim.api.nvim_win_get_buf(0)

  if bufnr == 0 then
    vim.notify("Cannot create installer buffer!", "error", { title = "dapinstall" })

    return
  end

  local shell = vim.o.shell

  vim.opt.shell = "bash"

  vim.fn.termopen("set -e\n" .. script, {
    cwd = dir:expand(),
    on_exit = on_exit,
  })

  vim.cmd "wincmd p"

  vim.opt.shell = shell
end

return { install = install }
