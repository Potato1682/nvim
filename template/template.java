:%s;<+PACKAGE+>;\=matchstr(substitute(expand('%:p'), '/\|\\', '\.', 'g'), 'src\.main\.java\.\(\w\.\)*\zs.\+\ze.java')
package <+PACKAGE+>

class <+CLASS NAME+> {
	<+CURSOR+>
}

