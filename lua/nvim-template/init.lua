vim.cmd [[ autocmd User plugin-template-loaded silent! %s/<+FILE NAME+>/\=expand('%:t')/g ]]
vim.cmd [[ autocmd User plugin-template-loaded silent! %s/<+CLASS NAME+>/\=expand('%:t:r')/g ]]
vim.cmd [[ autocmd User plugin-template-loaded if search('<+CURSOR+>') | execute 'normal! "_da>' | endif ]]

