:%s;<+CLASS NAME+>;\=substitute(expand('%:t:r'), '\CC\ze\u\w*', '', '')
:call rename(expand('%'), expand('%:p:h') . "/" . substitute(expand('%'), '\CC\ze\w*\.ts', '', '')) | lua vim.cmd("f " .. vim.fn.expand('%:p:h') .. "/" .. vim.fn.substitute(vim.fn.expand('%:t:r'), [[\CC\ze\w*]], '', '') .. ".ts")
package <+PACKAGE+>

class <+CLASS NAME+> {
  <+CURSOR+>
}

export default <+CLASS NAME+>

