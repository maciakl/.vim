" Custom VIM Settings
" Luke Maciak (2013)
" Vim 7.3 recommended.

"============= Runtime Stuff =============
" probably not necessary, but...
set nocompatible

" Enable mouse usage (all modes) in terminals
set mouse=a

" change the leader key to , (comma)
" while the default \ is nice, comma is faster
let mapleader=","

" use blowfish encryption (stronger than standard)
" Why? Just because.
if v:version >= 703
    set cryptmethod=blowfish
endif

" windows stuff (ignore on Linux)
if has('win32')
    " Use Consolas font, size 13
    set gfn=Consolas:h13:cANSI

    " make Cygwin the default shell on windows
    " this ensures that escaping to shell works as expected
    set shellxquote=
    set shellpipe=2>&1\|tee
    set shellredir=>%s\ 2>&1
    set shellslash

    " Fix Ruby path to ensure things are working
    " this may need to be changed on your system
    let g:ruby_path = ':C:\Ruby193\bin'


    " options for Mac only
elseif has('mac')
    " Use Monaco font, size 13
    set gfn=Monaco:h13	

    " disable the annoying Byte Order Mark that ruins shell scripts
    set nobomb

    " options for every other system
else
    " use Inconsolata, size 12 everywhere else 
    set gfn=Inconsolata\ Medium\ 10
endif

"============= GUI Options ============= 
" These affect GVim, not console Vim

" remove unnecessary toolbars
if has('gui_running')
    set guioptions-=T 			" disable tool bar
    set guioptions-=m 			" disable menu bar

    " make the default window bigger 	
    set lines=45 columns=160
endif

"============= Key Mappings ============= 

" press ; to issue commands in normal mode (no more shift holding)
nnoremap ; :

" move by screen lines, not by real lines - great for creative writing
nnoremap j gj
nnoremap k gk

" also in visual mode
vnoremap j gj
vnoremap k gk
"vnoremap <up> gk
"vnoremap <down> gj

" make up and down arrows work in insert mode
" c-o jumps to normal mode for one command
inoremap <up> <C-O>gk
inoremap <down> <C-O>gj

" insert current date on F10 - useful for dated logs or journals
:nnoremap <F10> "=strftime("%a %b %d, %Y")<CR>P
:inoremap <F10> <C-R>=strftime("%a %b %d, %Y")<CR>

" run ctags on current directory recursively
nnoremap <f6> :!ctags -R<cr>

" pressing <leader><space> clears the search highlights
nmap <silent> <leader><space> :nohlsearch<CR> 

" break a line at cursor without exiting normal mode
nnoremap <silent> <leader><CR> i<CR><ESC>

" insert a blank line with <leader>o and <leader>O
nnoremap <silent> <leader>o o<ESC>
nnoremap <silent> <leader>O O<ESC>

" use jj to quickly escape to normal mode while typing 
inoremap jj <ESC>

" toggle paste mode (to paste properly indented text)
nnoremap <F3> :set invpaste paste?<CR>
set pastetoggle=<F3>
set showmode

" use ,y and ,p to copy and paste from system clipboard
noremap <leader>y "+y
noremap <leader>Y "+Y
noremap <leader>p "+p
noremap <leader>P "+P

" automatically jump to last misspelled word and attempt replacing it
noremap <C-l> [sz=

" use Ctrl+L in insert mode to correct last misspelled word
inoremap <C-l> <esc>[sz=
" jump back to last insert point
noremap <C-i> gi

" Ctrl+Backspace deletes last word
inoremap <C-BS> <esc>bcw

" Ctrl+Del deletes next word
inoremap <C-Del> <esc>wcw

" repeated C-r pastes in the contents of the unnamed register
inoremap <C-r><C-r> <C-r>"

noremap <leader>blk I<blockquote><esc>A</blockquote><esc>

" Markdown bindings: make headers
nnoremap <silent> <leader>h1 YpVr=
nnoremap <silent> <leader>h2 YpVr-

" reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" use regular regex syntax rather than vim regex
nnoremap / /\v
vnoremap / /\v

" Remap gm to skip to the actual middle of the line, not middle of screen
noremap gm :call cursor(0, virtcol('$')/2)<CR>

"============= Buffers =============

" buffers can exist in background without being in a window
set hidden

" Automatically save before commands like :next and :make
set autowrite

" buffer browsing
nnoremap <Left> :bprev<CR>
nnoremap <Right> :bnext<CR>
" show buffer list
nnoremap <Up> :buffers<CR>:buffer<SPACE>
" jump to previous buffer
nnoremap <Down> <C-^>

" Alt Tab to cycle through buffers
nnoremap <Tab> :bnext<CR>

"============= Editing Vimrc =============

" open my vimrc in a split
command! VIMRC :e $HOME/.vim/.vimrc

" now source it
command! SOURCE source $MYVIMRC

"============ Saving and Closing ============

" for when you mess up and hold shift too long (using ! to prevent errors while 
" sourcing vimrc after it was updated)
command! W w
command! WQ wq
command! Wq wq
command! Q q

" changing file types:
command! DOS set ff=dos 	" force windows style line endings
command! UNIX set ff=unix 	" force unix style line endings
command! MAC set ff=mac 	" force mac style line endings

" This will display the path of the current file in the status line
" It will also copy the path to the unnamed register so it can be pasted
" with p or C-r C-r
command! FILEPATH call g:getFilePath()

function! g:getFilePath()
    let @" = expand("%:p")
    echom "Current file:" expand("%:p")
endfunc

"============= Session Handling =============

" where do you want to save sessions?
let g:session_dir = $HOME."/.vimsessions"

" set session name
command! -nargs=1 Ses let g:sessionname=<f-args>

" Save sessions whenever vim closes
autocmd VimLeave * call SaveSession()

" Load session when vim is opened
autocmd VimEnter * nested call OpenSession()

" Saves the session to session dir. Creates session dir if it doesn't
" yet exist. Sessions are named after servername paameter
function! SaveSession()

    " get the server (session) name
    if exists("g:sessionname")
        let s = g:sessionname
    else
        let s = v:servername
    endif

    " create session dir if needed
    if !isdirectory(g:session_dir)
        call mkdir(g:session_dir, "p")
    endif

    " save session using the server name
    execute "mksession! ".g:session_dir."/".s.".session.vim"
endfunc

" Open a saved session if there were no file-names passed as arguments
" The session opened is based on servername (session name). If there
" is no session for this server, none will be opened
function! OpenSession()

    " check if file names were passed as arguments
    if argc() == 0

        let sn = v:servername
        let file = g:session_dir."/".sn.".session.vim"

        " if session file exists, load it
        if filereadable(file)
            execute "source ".file
        endif

    endif
endfunc

"============ Snipmate ==========

" Open or create a custom SnipMate snippet file for the current file type
" I use this to quickly add snippets from currently edited files
command! SNIP call g:editSnipmateFile()
function! g:editSnipmateFile()
    let p=$HOME."/.vim/bundle/snipmate-custom-snippets/snippets/".&ft.".snippets"
    :exec "edit ".p
endfunc

"============= Spell Check =============

set spell 		"enable in-line spell check
set spelllang=en

"============= Line Numbers =============

" Line numbers (set relative in 7.3 because it's useful); 
" Fall back to absolute if 7.2 and lower
if v:version >= 703
    set rnu 	" if version 7.3 set relative line numbers
else
    set nu		" otherwise set absolute, because there is no rnu
endif

set cul		" highlight cursor line 
set nopaste	" pasting with auto-indent disabled (breaks bindings in cli vim)

" toggle between relative and absolute line numbers
function! g:ToggleNuMode()
    if(&rnu == 1)
        set nu
    else
        set rnu
    endif
endfunc

" map the above function to F5
nnoremap <f5> :call g:ToggleNuMode()<cr>

"============= Scrolling & Position Tweaks =============

" show line and column markers
set cursorline
set cursorcolumn

if v:version >= 703
    " for some reason this does not work in 7.2
    " highlight column 80
    set colorcolumn=80
endif

set scrolloff=3	" 3 line offset when scrolling

" turn off the *FUCKING* cursor blink
set guicursor=a:blinkon0

"============= Formatting, Indentation & Behavior =============

" enable soft word wrap
set formatoptions=l
set lbr

" Keep inserting comment leader character on subsequent lines
set formatoptions+=or

" use hard tabs for indentation
set tabstop=4
set softtabstop=4 	" makes backspace treat 4 spaces like a tab
set shiftwidth=4    " makes indents 4 spaces wide as well
set expandtab 		" actually, expand tabs into spaces
" set noexpandtab 	" don't expand tabs to spaces (cause fuck that)

set backspace=indent,eol,start

au FocusLost * silent! :wa	" save when switching focus 

"============= Search & Matching =============

set showcmd			" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching

set incsearch		" incremental search
set hlsearch		" highlights searches

set noerrorbells 	" suppress audible bell
set novisualbell 	" suppress bell blink

"============= History =============

" save more in undo history
set history=1000000
set undolevels=1000000

if v:version >= 703
    set undofile        " keep a persistent backup file
    set undodir=$TEMP
endif


"=========== Syntax Highlighting & Indents ==============
syntax on
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

set autoindent 		" always indent
set copyindent 		" copy previous indent on autoindenting
set smartindent

set backspace=indent,eol,start 	" backspace over everything in insert mode

" ============== Status Line ==============

set ls=2 			" Always show status line
set laststatus=2

"============== Folding ==============

set nofoldenable 	" screw folding

"set foldmethod=indent
"set foldnestmax=3
"set foldenable

"============== Completion ==============

set wildmenu
set wildmode=list:longest
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o,*.obj,*~

" longer more descriptive auto-complete prompts
set completeopt=longest,menuone
set ofu=syntaxcomplete#Complete

"============== Swap Files ==============

set noswapfile 		" suppress creation of swap files
set nobackup 		" suppress creation of backup files
set nowb 			" suppress creation of ~ files

"============== Filetypes ==============

" type detection for JSON files (makes snippets work)
au! BufRead,BufNewFile *.json set filetype=json 

" force txt files to be highlighted as html
au BufRead,BufNewFile *.txt setfiletype html

" Fix HTML indenting quirk as per http://bit.ly/XnlHJz
autocmd FileType html setlocal indentkeys-=*<Return>

" force php files to be treated as php/html - necessary for snipmate to work
"au BufRead,BufNewFile *.php set filetype=php.html

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

"============== Pathogen ==============
" Plugin manager:
" Lets you store your plugins in individual folders
" inside the .vim/bundle directory (also as git submodules).
" This line initializes it and loads all plugins:
call pathogen#infect()


"============== Plugin Specific Settings ==============
" Must be specified after pathogen#infect call to take
" effect. These modify plugin behavior.

" Solarized color scheme setup:
if has('gui_running')
    " use the light (yellowish background) scheme in GUI
    set background=light
else
    " specific settings for terminal 
    set t_Co=256                        " force vim to use 256 colors
    let g:solarized_termcolors=256      " use solarized 256 fallback
    set background=light                " change this if you want dark scheme

    " Tell vim to change the shape of the cursor based on mode
    " only works in some terminals (won't work over ssh usually)
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" enable solarized color scheme
colorscheme solarized

" change the color of the column 80
" this needs to be called after solarized
highlight ColorColumn guibg=lightyellow ctermbg=227

" Change color of the list characters and use
" special chars to indicate tabs and newlines
" These can be displayed using :set list!
set listchars=tab:▸\ ,eol:¬
highlight NonText guifg=orange
highlight SpecialKey guifg=orange


" bind NERDTree to F1 (we don't need help)
nnoremap <f1> :NERDTreeToggle<cr>

" bind TagList to F2
nnoremap <f2> :TlistToggle<cr>

" force snipmate accept custom defined snippets on windows
" on other platform this seems to work out of the box, but on windows
" you have to specify the directories in correct order manually.
" I keep custom snippets in .vim/bundle/snipmate-custom-snippets directory
if has('win32')
    let g:snippets_dir="c:/Users/luke/.vim/bundle/snipmate/snippets/,c:/Users/luke/.vim/bundle/snipmate-custom-snippets/snippets"
endif

" key binding for the Gundo (undo preview) plugin
nnoremap <F7> :GundoToggle<CR>

" bind the PHPDoc command to C-P only for php files
nnoremap <C-P> :call PhpDoc()<CR> 
" fixing comment style for PHP (this got changed somewhere)
au Filetype php set comments=sr:/**,m:*\ ,ex:*/,://


" OBVIOUS-MODE FIXES
" for some reason obvious-mode color values were wrong for the latest version
" of Solarized theme so this fixes the issue and makes obvious-mode behave as
" it should (ie colorizes the background and not the foreground).
let g:obviousModeInsertHi = 'term=reverse ctermfg=52 guifg=darkred'
let g:obviousModeCmdwinHi = 'term=reverse ctermfg=22 guifg=darkblue'
let g:obviousModeModifiedCurrentHi = 'term=reverse ctermfg=30 guifg=darkcyan'
let g:obviousModeModifiedNonCurrentHi = 'term=reverse ctermfg=30 guifg=darkcyan'
let g:obviousModeModifiedVertSplitHi = 'term=reverse ctermbg=22 ctermfg=30 guibg=darkblue guifg=darkcyan'
