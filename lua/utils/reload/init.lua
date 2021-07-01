local M = {}

local Path = require "plenary.path"

local scandir = require("plenary.scandir").scan_dir

M.lua_reload_directories = { vim.fn.stdpath "config" }
M.vim_reload_directories = { vim.fn.stdpath "data" .. "/site/pack/*/start/*" }

M.vim_subdirectories = {
  "compiler",
  "doc",
  "keymap",
  "syntax",
  "plugin",
}

local function escape_str(str)
  local patterns_to_escape = {
    "%^",
    "%$",
    "%(",
    "%)",
    "%%",
    "%.",
    "%[",
    "%]",
    "%*",
    "%+",
    "%-",
    "%?",
  }

  return str:gsub(string.format("([%s])", table.concat(patterns_to_escape)), "%%%1")
end

local function path_exists(path)
  return Path:new(path):exists()
end

local function get_runtime_files_in_path(runtimepath)
  if runtimepath:match("/site/pack/.-/opt") then
    return {}
  end

  local runtime_files = {}

  for _, subdir in ipairs(M.vim_subdirectories) do
    local viml_path = string.format("%s/%s", runtimepath, subdir)

    if path_exists(viml_path) then
      local files = scandir(viml_path, { search_pattern = "%.n?vim$", hidden = true })

      for _, file in ipairs(files) do
        runtime_files[#runtime_files + 1] = file
      end
    end
  end

  return runtime_files
end

local function get_lua_modules_in_path(runtimepath)
  local luapath = string.format("%s/lua", runtimepath)

  if not path_exists(luapath) then
    return {}
  end

  local modules = scandir(luapath, { search_pattern = "%.lua$", hidden = true })

  for i, module in ipairs(modules) do
    module = module:match(string.format("%s/(.*)%%.lua", escape_str(luapath)))

    module = module:gsub("/", ".")

    module = module:gsub("%.init$", "")

    modules[i] = module
  end

  return modules
end

local function reload_runtime_files()
  for _, runtimepath_suffix in ipairs(M.vim_reload_dirs) do
    local paths = vim.fn.glob(runtimepath_suffix, 0, 1)

    for _, path in ipairs(paths) do
      local runtime_files = get_runtime_files_in_path(path)

      for _, file in ipairs(runtime_files) do
        vim.cmd("source " .. file)
      end
    end
  end
end

local function unload_lua_modules()
  for _, runtimepath_suffix in ipairs(M.lua_reload_directories) do
    local paths = vim.fn.glob(runtimepath_suffix, 0, 1)

    for _, path in ipairs(paths) do
      local modules = get_lua_modules_in_path(path)

      for _, module in ipairs(modules) do
        package.loaded[module] = nil
      end
    end
  end
end

function M.reload()
  vim.cmd "highlight clear"

  if vim.fn.exists ":LspStop" ~= 0 then
    vim.cmd "LspStop"
  end

  unload_lua_modules()

  vim.cmd "luafile $MYVIMRC"

  reload_runtime_files()
end

function M.restart()
  M.reload()

  vim.cmd "doautocmd VimEnter"
end

return M
