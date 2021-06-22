local function install(name, dir, script)
  vim.fn.mkdir(dir, "p")

  local function onExit(_, code)
    if code ~= 0 then
      error("[dapinstall] Couldn't install " .. name .. " server!")
    end
    print("[dapinstall] Successfully installed " .. name .. " server!")
  end

  vim.cmd "new"

  local shell = vim.o.shell
  vim.o.shell = "/usr/bin/bash"
  vim.fn.termopen("set -e\n" .. script, { cwd = dir, on_exit = onExit })
  vim.o.shell = shell
  vim.cmd "startinsert"
end

return { install = install }
