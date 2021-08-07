nmap     <buffer>  <leader>wa  <Plug>(go-alternate-edit)
nmap     <buffer>  <leader>wt  <Plug>(go-test-func)
nmap     <buffer>  <leader>wc  <Plug>(go-coverage-toggle)
nnoremap <buffer>  <leader>wg  :CocCommand go.tags.add.prompt<CR>

autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
