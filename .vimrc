"============= Runtime Stuff =============

set nocompatible
runtime! debian.vim

set gfn=Inconsolata\ Medium\ 12

" windows stuff (ignore on linux)
if has('win32')
	source $VIMRUNTIME/vimrc_example.vim
	source $VIMRUNTIME/mswin.vim
	set gfn=Consolas:h10:cANSI " windows only font
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

" run ctags on current directory recursively
nnoremap <f6> :!ctags -R<cr>

" pressing \<space> clears the search highlights
nmap <silent> <leader><space> :nohlsearch<CR> 

" break a line at cursor 
nmap <silent> <leader><CR> i<CR><ESC>

" use jj to quickly escape to normal mode while typing 
inoremap jj <ESC>

" toggle paste mode (to paste properly indented text)
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" use regular regex syntax rather than vim regex
nnoremap / /\v
vnoremap / /\v

"============= Buffers =============

set hidden 	" buffers can exist in background without being in a window

"============= Spell Check =============

set spell 		"enable in-line spell check
set spelllang=en

"============= Line Numbers =============

set nu 		" line numbers
set cul		" highlight cursor line 
set paste	" pasting with auto-indent

"============= Scrolling =============

" show line and column markers
set cursorline
set cursorcolumn

set scrolloff=3	" 3 line offset when scrolling

"============= Formatting & Behavior =============

" enable soft word wrap
set formatoptions=l
set lbr

behave mswin 	" will accept ctrl+c, ctrl+c, ctrl+v if you slip up

au FocusLost * silent! :wa	" save when switching focus 

"============= Search & Matching =============

set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching

set incsearch		" incremental search
set hlsearch		" highlights searches

set noerrorbells
set novisualbell

"============= History =============

" save more in undo history
set history=1000
set undolevels=1000


if v:version >= 730
	set undofile        " keep a persistent backup file
endif


"============= Misc =============

set autowrite		" Automatically save before commands like :next and :make
set mouse=a		" Enable mouse usage (all modes) in terminals

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

set ls=2 " Always show status line
set laststatus=2

"============== Folding ==============

set nofoldenable
"set foldmethod=indent
"set foldnestmax=3
"set foldenable

"============== Completion ==============

set wildmenu
set wildmode=list:longest
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o,*.obj,*~

"============== Swap Files ==============

set noswapfile
set nobackup
set nowb

"============== Misc ==============

" Load indentation rules according to the detected filetype. 
if has("autocmd")
	filetype indent on
endif

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
	source /etc/vim/vimrc.local
endif


" force txt files to be highlighted as html
au BufRead,BufNewFile *.txt setfiletype html

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

" Solarized color scheme setup
if has('gui_running')
	" use the light (yellowish background) scheme in GUI
	set background=light
else
	" change to dark color scheme on terminal
	set background=dark

	" if running on windows, degrade to 256 colors because the windows
	" terminal sucks very, very much and vim in GitBash looks awful
	if has('win32')
		let g:solarized_termcolors
	endif

endif

" enable solarized color scheme
colorscheme solarized



" bind NERDTree to F1 (we don't need help)
nnoremap <f1> :NERDTreeToggle<cr>


" force snipmate accept custom defined snippets on windows
if has('win32')
	let g:snippets_dir="c:/Users/luke/.vim/bundle/snipmate/snippets/,c:/Users/luke/.vim/bundle/snipmate-custom-snippets/snippets"
endif


" MiniBufExpl Plugin Settings
let g:miniBufExplMapCTabSwitchBufs = 1 
