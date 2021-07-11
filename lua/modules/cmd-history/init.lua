local M = {}

local ignore_commands = vim.tbl_extend("force", {
  "^buf$",
  "^history$",
  "^h$",
  "^q$",
  "^qa$",
  "^w$",
  "^wq$",
  "^wa$",
  "^wqa$",
  "^q!$",
  "^qa!$",
  "^w!$",
  "^wq!$",
  "^wa!$",
  "^wqa!$",
  "^e$",
  "^e!$",
}, O.ignore_commands)

local function copy(obj, seen)
  if type(obj) ~= "table" then
    return obj
  end

  if seen and seen[obj] then
    return seen[obj]
  end

  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))

  s[obj] = res

  for k, v in pairs(obj) do
    res[copy(k, s)] = copy(v, s)
  end

  return res
end

function M.clean()
  vim.tbl_filter(function(i, v)
    vim.fn.histdel(":", v)
  end, copy(ignore_commands))
end

return M
