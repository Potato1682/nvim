local Path = require "plenary.path"
local Job = require "plenary.job"

local function install(name, dir, script)
  if type(dir) == "string" then
    dir = Path:new(dir)
  end

  dir:mkdir({ parents = true, exists_ok = true })

  local function chan_writer(chan)
    return vim.schedule_wrap(function(_, data)
      vim.api.nvim_chan_send(chan, data .. "\r\n")
    end)
  end

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

  local shell = vim.opt.shell:get()

  vim.opt.shell = "bash"

  local chan = vim.api.nvim_open_term(bufnr, {})

  if chan == 0 then
    vim.notify("Cannot create terminal instance!", "error", { title = "fmtinstall" })
  end

  Job
    :new({
      command = "bash",
      args = { "-c", '"set -e\n' .. script .. '"' },
      cwd = dir,
      on_exit = on_exit,
      on_etdout = chan_writer(chan),
      on_stderr = chan_writer(chan),
    })
    :start()

  vim.opt.shell = shell
end

return { install = install }
