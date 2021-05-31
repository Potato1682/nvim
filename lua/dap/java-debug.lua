local debug_install_dir = vim.fn.stdpath("data") .. "/dapinstall/java/"

local function install(name, script)
  if vim.fn.confirm("Install " .. name .. " server?", "&Yes\n&Cancel") ~= 1 then return end

  vim.fn.mkdir(debug_install_dir, "p")

  local function onExit(_, code)
    if code ~= 0 then
      error("Couldn't install " .. name .. " server!")
    end
    print("Successfully installed " .. name .. " debug server!")
  end

  vim.cmd("new")

  local shell = vim.o.shell
  vim.o.shell = "/usr/bin/bash"
  vim.fn.termopen("set -e\n" .. script, { cwd = debug_install_dir, on_exit = onExit })
  vim.o.shell = shell
  vim.cmd("startinsert")
end

local java_debug_dir = debug_install_dir .. "java-debug"
local java_test_dir = debug_install_dir .. "java-test"

if vim.fn.glob(java_debug_dir) == "" then
  install("java debug", [[
    git clone https://github.com/microsoft/java-debug --depth 1 --recursive && cd java-debug
    ./mvnw clean install
  ]])
end

if vim.fn.glob(java_test_dir) == "" then
  install("java test runner", [[
    git clone https://github.com/microsoft/vscode-java-test java-test --depth 1 --recursive && cd java-test
    npm i
    npm run build-plugin
  ]])
end

