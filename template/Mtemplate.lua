:call rename(expand('%'), expand('%:p:h') . "/" . substitute(expand('%'), '\CM\ze\w*\.lua', '', '')) | lua vim.cmd("f " .. vim.fn.expand('%:p:h') .. "/" .. vim.fn.substitute(vim.fn.expand('%:t:r'), [[\CM\ze\w*]], '', '') .. ".lua")
local M = {}

<+CURSOR+>

return M
