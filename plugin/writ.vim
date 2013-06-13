command! WRIT call WritToggle()

let s:writ = 0

function! WritToggle()
    if s:writ
    	let s:writ = 0
    	set foldcolumn=0
        SOURCE
    else
        let s:writ = 1
        setlocal nonumber
        setlocal norelativenumber
        set foldcolumn=2
        set columns=82
        let &guifont=substitute(&guifont, ':h\zs\d\+', '\=submatch(0)+3', '')
    endif
endfunc
