command! WRIT call WritToggle()
nnoremap \ gqip
nnoremap <S-\> gggqG
nnoremap <C-\> :WRIT<cr>

let s:writ = 0

function! WritToggle()
    if s:writ
    	let s:writ = 0
    	set foldcolumn=0
        SOURCE
    else
    	SOURCE
        let s:writ = 1
        setlocal nonumber
        setlocal norelativenumber
        set foldcolumn=5
        set columns=85

        "setlocal formatoptions=ant
        setlocal textwidth=80
        setlocal wrapmargin=0

        "setlocal noautoindent
        "setlocal nocindent
        "setlocal nosmartindent
        "setlocal indentexpr=

        "let &guifont=substitute(&guifont, ':h\zs\d\+', '\=submatch(0)+1', '')
        "normal gggqG
        "write
    endif
endfunc
