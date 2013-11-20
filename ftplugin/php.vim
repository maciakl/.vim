" PHP as per PSR-1
" Use 4 spaces for indentation, utf-8 with no BOM and unix line endings
setlocal shiftwidth=4 
setlocal softtabstop=4 
setlocal tabstop=4 
setlocal nobomb 
setlocal enc=utf-8 
setlocal ff=unix
setlocal comments=sr:/**,m:*\ ,ex:*/,://

" bind the PHPDoc command to C-P only for php files
nnoremap <C-P> :call PhpDoc()<CR>
