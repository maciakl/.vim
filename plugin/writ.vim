command! WRIT call WritToggle()

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
        set foldcolumn=3
        set columns=83
        let &guifont=substitute(&guifont, ':h\zs\d\+', '\=submatch(0)+1', '')
    endif
endfunc
