local dir = vim.fn.stdpath("data") .. "/site/pack/packer/opt/"

local function download()
  print("  > mkdir -p " .. dir)
  vim.fn.mkdir(dir, "p")

  local command = string.format("git clone https://github.com/wbthomason/packer.nvim %s", dir .. "packer.nvim")

  print("  > " .. command)
  vim.fn.system(command)
end

return function()
  if vim.fn.glob(dir .. "packer.nvim") == "" then
    if vim.fn.confirm("Install packer.nvim?", "&Yes\n&Cancel") ~= 1 then
      return
    end

    print("( 1 / 2 ) Download packer.nvim")
    download()

    print("( 2 / 2 ) Install plugins")
    print("  : packadd packer.nvim ")
    print([[ >> require"plugins".sync() ]])
    vim.cmd [[ PackerSync ]]

    print("Restart to use nvim. Enjoy!")

    return true
  end

  return false
end

