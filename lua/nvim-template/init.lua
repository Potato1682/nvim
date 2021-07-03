-- Define filename replace keyword
vim.cmd [[ autocmd User plugin-template-loaded silent! %s/<+FILE NAME+>/\=expand('%:t')/g ]]

-- Define ClassName replace keyword
vim.cmd [[ autocmd User plugin-template-loaded silent! %s/<+CLASS NAME+>/\=expand('%:t:r')/g ]]

-- Evaluate in vim
vim.cmd [[ autocmd User plugin-template-loaded silent %s/<%=\(.\{-}\)%>/\=eval(submatch(1))/ge ]]

-- Move the cursor to this
vim.cmd [[ autocmd User plugin-template-loaded if search('<+CURSOR+>') | execute 'normal! "_da>' | endif ]]
