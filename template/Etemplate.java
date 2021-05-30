:%s;<+PACKAGE+>;\=substitute(substitute(expand('%:p:h'), '/\|\\', '\.', 'g'), '\(\w\.\)*src\.main\.java\.', '', '') .. "." .. matchstr(substitute(expand('%:p'), '/\|\\', '\.', 'g'), '\Csrc\.main\.java\.\(\w\+\.\)*E\zs.\+\ze.java')
:%s;<+ICLASS NAME+>;\=substitute(expand('%:t:r'), '\CE\ze\u\w*', '', '')
:call rename(expand('%'), expand('%:p:h') . "/" . substitute(expand('%'), '\CE\ze\u\w*\.java', '', '')) | lua vim.cmd("f " .. vim.fn.expand('%:p:h') .. "/" .. vim.fn.substitute(vim.fn.expand('%:t:r'), [[\CE\ze\u\w*]], '', '') .. ".java") 
package <+PACKAGE+>

enum <+ICLASS NAME+> {
	<+CURSOR+>
}

