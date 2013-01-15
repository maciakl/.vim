"============= Runtime Stuff =============

" probably not necessary, but...
set nocompatible

" change the leader key to ,
let mapleader=","

" use blowfish encryption (stronger than standard)
if v:version >= 703
	set cryptmethod=blowfish
endif


" windows stuff (ignore on Linux)
if has('win32')
	set gfn=Consolas:h13:cANSI 					" when on Windows use Consolas
    
    " make cygwin the default shell on windows
    set shellxquote=
    set shellpipe=2>&1\|tee
    set shellredir=>%s\ 2>&1
    set shellslash

    let g:ruby_path = ':C:\Ruby193\bin'


elseif has('mac')
	set gfn=Monaco:h13	    					" use the Monaco font when on Mac
else
    " use Inconsolata everywhere else 
    set gfn=Inconsolata\ Medium\ 12
endif

" Enable UTF-8 support so that I can type polish characters
if has("multi_byte")
	" set encoding on terminal if not set
	if &termencoding == ""
		let &termencoding = &encoding
	endif
	" force utf-8
	set encoding=utf-8
	setglobal fileencoding=utf-8 bomb
	set fileencodings=ucs-bom,utf-8,latin1
endif

"============= GUI Options ============= 

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
nnoremap <up> gk
nnoremap <down> gj

" also in visual mode
vnoremap j gj
vnoremap k gk
vnoremap <up> gk
vnoremap <down> gj

" make up and down arrows work in insert mode
" c-o jumps to normal mode for one command
inoremap <up> <C-O>gk
inoremap <down> <C-O>gj

" insert current date on F10 - useful for dated logs or journals
:nnoremap <F10> "=strftime("%a %b %d, %Y")<CR>P
:inoremap <F10> <C-R>=strftime("%a %b %d, %Y")<CR>

" run ctags on current directory recursively
nnoremap <f6> :!ctags -R<cr>

" pressing \<space> clears the search highlights
nmap <silent> <leader><space> :nohlsearch<CR> 

" break a line at cursor 
nnoremap <silent> <leader><CR> i<CR><ESC>

" insert a blank line with <leader>o and <leader>O
nnoremap <silent> <leader>o o<ESC>
nnoremap <silent> <leader>O O<ESC>

" use jj to quickly escape to normal mode while typing 
inoremap jj <ESC>

" shift Tab to cycle through buffers
nnoremap <S-Tab> :bnext<CR>

" toggle paste mode (to paste properly indented text)
nnoremap <F3> :set invpaste paste?<CR>
set pastetoggle=<F3>
set showmode

" run current PHP file through php interpreter
:autocmd FileType php noremap <leader>p :w!<CR>:!php %<CR>
" run current PHP file through php linter (syntax check) check
:autocmd FileType php noremap <leader>l :!php -l %<CR>

" use \y and \p to copy and paste from system clipboard
noremap <leader>y "+y
noremap <leader>Y "+Y
noremap <leader>p "+p
noremap <leader>P "+P

" automatically jump to last misspelled word and attempt replacing it
noremap <leader>ss [sz=
noremap <leader>aa [sz=1<cr><cr>

" use Ctrl+L in insert mode to correct last misspelled word
inoremap <C-l> <esc>[sz=
noremap <C-i> gi

" Ctrl+Backspace deletes last word
inoremap <C-BS> <esc>bcw

" Ctrl+De; deletes next word
inoremap <C-Del> <esc>wcw

" open my vimrc in a split
command! VIMRC vsplit $MYVIMRC

" now source it
command! SOURCE source $MYVIMRC

" repeated C-r pastes in the contents of the unnamed register
inoremap <C-r><C-r> <C-r>"

" surround the current word with quotes
nnoremap <leader>' ciw"<C-r>""<esc>
nnoremap <leader>, ciw<<C-r>"><esc>
nnoremap <leader>( ciw(<C-r>")<esc>

" surround word/sentence with emp, strong
noremap <leader>e ciw<emp><C-r>"</emp><esc>
noremap <leader>E cis<emp><C-r>"</emp><esc>

noremap <leader>s ciw<strong><C-r>"</strong><esc>
noremap <leader>S cis<strong><C-r>"</strong><esc>

noremap <leader>blk I<blockquote><esc>A</blockquote><esc>

" Markdown bindings
nnoremap <silent> <leader>h1 YpVr=
nnoremap <silent> <leader>h2 YpVr-

noremap <leader>b ciw**<C-r>"**<esc>
noremap <leader>B cis**<C-r>"**<esc>
noremap <leader>i ciw*<C-r>"*<esc>
noremap <leader>I cis*<C-r>"*<esc>

" run current buffer through markdown converter
" you should have the Markdown.pl in your .vim directory for convenience
if filereadable($HOME."/.vim/Markdown.pl")

	" run Markdown.pl on current file and dump the output to a .html file
	" then attempt to open that file in a web browser
	function! g:Markdown()
		exe "!".$HOME."/.vim/Markdown.pl --html4tags % > %.html"

		" on Windows use default web browser. Elsewhere try chrome in
		" incognito mode (no plugins). Feel free to change that to your
		" favorite browser.
		if has('win32')
			exe "! %.html"
		else
			exe "! google-chrome --incognito %.html"
		endif

	endfunc

	" bind this function to :M
	command! M call g:Markdown()
	
	" autocmd FileType html,htm,mkd,markdown nnoremap <leader>md :exe "%! ".$HOME."/.vim/Markdown.pl --html4tags"<cr>
endif


" use regular regex syntax rather than vim regex
nnoremap / /\v
vnoremap / /\v

"============= Command Aliases =============

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

"============= Buffers =============

set hidden 	" buffers can exist in background without being in a window

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
set history=1000
set undolevels=1000

if v:version >= 703
	set undofile        " keep a persistent backup file
	set undodir=$TEMP
endif


"============= Misc =============

set autowrite		" Automatically save before commands like :next and :make
set mouse=a			" Enable mouse usage (all modes) in terminals

" sudo save file with w!
cmap w!! w !sudo tee % >/dev/null

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

"============== Misc ==============

" force txt files to be highlighted as html
au BufRead,BufNewFile *.txt setfiletype html

" force php files to be treated as php/html - necessary for snipmate to work
au BufRead,BufNewFile *.php set filetype=php.html

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

"============== Pathogen ==============

call pathogen#infect()


"============== Plugin Specific Settings ==============

" This is necessary to make Gdiff work
let g:miniBufExplorerMoreThanOne=3

" Solarized color scheme setup
if has('gui_running')
	" use the light (yellowish background) scheme in GUI
	set background=light
else
	" specific settings for terminal 
	set t_Co=256                        " force vim to use 256 colors
	let g:solarized_termcolors=256      " use solarized 256 fallback
	set background=light                " change this if you want dark scheme

    " Tell vim to change the shape of the cursor based on mode
	let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"

endif

" enable solarized color scheme
colorscheme solarized

" change the color of the column 80
" this needs to be called after solarized
highlight ColorColumn guibg=lightyellow


" bind NERDTree to F1 (we don't need help)
nnoremap <f1> :NERDTreeToggle<cr>

" TagList shortcut
nnoremap <f2> :TlistToggle<cr>

" force snipmate accept custom defined snippets on windows
if has('win32')
	let g:snippets_dir="c:/Users/luke/.vim/bundle/snipmate/snippets/,c:/Users/luke/.vim/bundle/snipmate-custom-snippets/snippets"
endif

" MiniBufExpl Plugin Settings
let g:miniBufExplMapCTabSwitchBufs = 1 

" phpDocumentor shortcut
nnoremap <leader>d :call PhpDoc()<cr>

" key binding for the Gundo (undo preview) plugin
nnoremap <F7> :GundoToggle<CR>

" bind the PHPDoc command to C-P only for php files
autocmd FileType php nnoremap <C-P> :call PhpDocSingle()<CR> 
