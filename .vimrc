"============= Runtime Stuff =============

" windows stuff (ignore on linux)
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim

runtime! debian.vim

"============= Buffers =============

set hidden 	" buffers can exist in background without being in a window

"============= Spell Check =============

set spell
set spelllang=en

"============= Line Numbers =============

set nu 		" line numbers
set cul		" highlight cursor line 
set paste	" pasting with auto-indent

"============= Scrolling =============

set cursorline
set cursorcolumn

set scrolloff=3	" 3 line offset when scrolling

"============= Formatting & Behavior =============

set formatoptions=l
set lbr
behave mswin " will accept ctrl+c, ctrl+c, ctrl+v if you slip up

"============= Search =============

set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching

"============= Misc =============

set autowrite		" Automatically save before commands like :next and :make
set mouse=a		" Enable mouse usage (all modes) in terminals

"=========== Syntax Highlighting & Indents ==============
syntax on
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

set autoindent
set smartindent

set gfn=Consolas:h10:cANSI " windows only font

" ============== Status Line ==============
"set laststatus=2
"set statusline=%<%f\%h%m%r%=%-20.(line=%l\ \ col=%c%V\ \ totlin=%L%)\ \ \%h%m%r%=%-40(bytval=0x%B,%n%Y%)\%P

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
set wildignore=*.o,*.obj,*~

"============== Search Settings ==============

set incsearch		" incremental search
set hlsearch		" highlights searches

"============== Swap Files ==============

set noswapfile
set nobackup
set nowb

"============== Misc ==============

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
"    \| exe "normal g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules according to the
" detected filetype. Per default Debian Vim only load filetype specific
" plugins.
if has("autocmd")
  filetype indent on
endif



" Source a global configuration file if available
" XXX Deprecated, please move your changes here in /etc/vim/vimrc
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


"============== Pathogen Plugin Settings ==============
"
if has('gui_running')
    set background=light
else
    set background=dark
endif

colorscheme solarized

