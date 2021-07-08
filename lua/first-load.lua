local dein_directory = vim.fn.stdpath "data" .. "/dein"
local dein_repository = dein_directory .. "/repos/github.com/Shougo/dein.vim"

local function download()
  print("  > mkdir -p " .. dein_repository)
  vim.fn.mkdir(dein_repository, "p")

  local command = string.format("git clone https://github.com/Shougo/dein.vim %s", dein_repository)

  print("  > " .. command)
  vim.fn.system(command)
end

return function()
  if not vim.o.runtimepath:match "/dein.vim" then
    if vim.fn.isdirectory(dein_repository) ~= 1 then
      if vim.fn.confirm("[fitst-load] Install dein?", "&Yes\n&Cancel") ~= 1 then
        return
      end

      print "( 1 / 2 ) Download dein"
      download()

      print "( 2 / 2 ) Enable dein"
      print("  : &runtimepath += " .. dein_repository)

      return true
    end
  end

  return false
end
