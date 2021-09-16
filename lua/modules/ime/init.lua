local M = {}

local os_name = vim.loop.os_uname().sysname

local function is_linux()
  return os_name == "Linux"
end

local function is_docker()
  if vim.fn.empty(vim.fn.expand(vim.fn.glob ".dockerenv")) ~= 1 then
    return true
  end

  if vim.fn.filereadable(vim.fn.expand "/proc/self/cgroup") ~= 1 then
    return false
  end

  if table.concat(vim.fn.readfile "/proc/self/cgroup", " "):find "docker" ~= nil then
    return true
  end

  return false
end

local function is_wsl()
  if not is_linux() then
    return false
  end

  local release = tostring(vim.fn.system "uname -a"):lower()

  if release:find "microsoft" ~= nil then
    if is_docker() then
      return false
    end

    return true
  end

  if vim.fn.filereadable "/proc/version" ~= 1 then
    return false
  end

  if table.concat(vim.fn.readfile "/proc/version", " "):lower():find "microsoft" ~= nil then
    return true
  end

  return false
end

function M.ime_disable()
  if is_wsl() then
    if not vim.fn.executable "zenhan" then
      return
    end

    vim.fn.system "zenhan 0"
  end

  if is_linux() then
    local ok, fcitx = pcall(require, "fcitx")

    if not ok then
      if vim.fn.executable "fcitx-remote" == 1 then
        vim.fn.system "fcitx-remote -c"
      elseif vim.fn.executable "fcitx5-remote" == 1 then
        vim.fn.system "fcitx5-remote -c"
      end

      return
    end

    fcitx.setCurrentInputMethod "keyboard-us"
  end
end

return M
