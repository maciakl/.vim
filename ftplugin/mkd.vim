" Markdown Settings

" Autocomplete from a dictionary
setlocal complete+=kspell

" Fix list formatting
setlocal comments=fb:*,fb:-,fb:+,n:> commentstring=>\ %s
setlocal formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^[-*+]\\s\\+


" Make headers the easy way
nnoremap <silent> <leader>H YpVr=
nnoremap <silent> <leader>h YpVr-

