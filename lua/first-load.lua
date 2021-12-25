local packpath = vim.fn.stdpath "data" .. "/site/pack/packer/"
local packer_path = packpath .. "opt/packer.nvim"

local function create_directories()
  local data_path = vim.fn.stdpath "data"

  for _, directory in ipairs { "undos", "swap", "sessions", "backup", "tags", "databases" } do
    print("  > mkdir -p " .. data_path .. "/" .. directory)
    vim.fn.mkdir(data_path .. "/" .. directory, "p")
  end
end

local function download()
  print("  > mkdir -p " .. packer_path)
  vim.fn.mkdir(packer_path, "p")

  local command = string.format("git clone https://github.com/wbthomason/packer.nvim --depth 1 %s", packer_path)

  print("  > " .. command)
  vim.fn.system(command)
end

return function()
  if vim.fn.empty(vim.fn.glob(packer_path .. "/*")) ~= 0 then
    if vim.fn.confirm("[fitst-load] Setup nvim?", "&Yes\n&Cancel") ~= 1 then
      return true
    end

    print "( 1 / 3 ) Create directories"
    create_directories()

    print "( 2 / 3 ) Download packer.nvim"
    download()

    print "( 3 / 3 ) Install plugins"
    print "  : packadd packer.nvim"
    print "  : PackerSync"
    print "    Registered automatic quit."
    vim.cmd [[ PackerSync ]]

    return true
  end

  return false
end
