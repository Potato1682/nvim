local function install(name, dir, script)
  if vim.fn.confirm("Install " .. name .. " server?", "&Yes\n&Cancel") ~= 1 then return end

  vim.fn.mkdir(dir, "p")

  local function onExit(_, code)
    if code ~= 0 then error("Couldn't install " .. name .. " server!") end
    print("Successfully installed " .. name .. " server!")
  end

  vim.cmd("new")

  local shell = vim.o.shell
  vim.o.shell = "/usr/bin/bash"
  vim.fn.termopen("set -e\n" .. script, { cwd = dir, on_exit = onExit })
  vim.o.shell = shell
  vim.cmd("startinsert")
end

return { install = install }

