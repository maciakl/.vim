My Personal Vim Settings
===

This is my personal git directory, under source control ready to be deployed
across across all platforms.

Plugis
---

These are the custom plugins I use:

* [Closetag.vim](https://github.com/vim-scripts/closetag.vim) - use `<c-_>` close HTML tags
* [Gundo](https://github.com/sjl/gundo.vim) - browse the undo tree in the sidebar
* [NERDcommenter](https://github.com/scrooloose/nerdcommenter) - auto-commenting
* [NERDtree](https://github.com/scrooloose/nerdtree) - file browser plugin
* [ObfiousMode](https://github.com/bsl/obviousmode) - change color of sidebar depending on mode
* [PHPDocumentator](https://github.com/vim-scripts/PDV--phpDocumentor-for-Vim) - generate PHPDoc comments
* [SnipMate](https://github.com/msanders/snipmate.vim) - auto-complete code snippets
* [Tabular](https://github.com/godlygeek/tabular) - auto-align code chunks
* [TagList](https://github.com/vim-scripts/taglist.vim) - browse the tag list
* [Unite.vim](https://github.com/Shougo/unite.vim) - file/buffer/history browsing
* [Vim-Align](https://github.com/tsaleh/vim-align) - auto-align code chunks (like Tabular)
* [Vim-AutoClose](https://github.com/Townk/vim-autoclose) - auto close parens and brackets
* [Vim-Fugitive](https://github.com/tpope/vim-fugitive) - git integration
* [Vim-SuperTab](https://github.com/tsaleh/vim-supertab) - super-charge the tab key
* [Vim-indent-object](https://github.com/michaeljsmith/vim-indent-object) - text object for Python indent block
* [Vim-matchit](https://github.com/edsono/vim-matchit) - skip to closing HTML tag with `%`
* [Vim-neatstatus](https://github.com/maciakl/vim-neatstatus) - simple status line with colors
* [Vim-surround](https://github.com/tpope/vim-surround) - bindings to easily surround text with stuff

Custom Key Bindings
---

The `<leader>` key is bound to `,`.

* `+` and `-`                   -  increment and decrement number under cursor
* `<C-BS>`                      -  ctrl+backspace deletes last word
* `<C-Del>`                     -  ctrl+Del deletes next word
* `<C-L>`                       -  fix last typo
* `<C-P>`                       -  generate PHPDoc comments at cursor
* `<C-R>`                       -  paste in contents of the unnamed register
* `<C-_>`                       -  close html tag
* `<Down>`                      -  search current directory for files with Unite
* `<F1>`                        -  toggle NERDTree file browser
* `<F2>`                        -  toggle Tag List buffer
* `<F3>`                        -  toggle paste mode
* `<F5>`                        -  toggle relative and absolute line numbering
* `<F6>`                        -  run `ctags` on project
* `<F7>`                        -  toggle Gundo undo browser
* `<F10>`                       -  insert current date at cursor
* `<Left>` and `<Right>`        -  browse through buffers
* `<Up>`                        -  search/display open buffers with Unite
* `<leader><cr>`                -  break line at cursor (normal mode)
* `<leader><space>`             -  clear search highlights
* `<leader>h1` and `<leader>h2` -  markdown headings
* `<leader>o`                   -  insert a blank line (normal mode) (also works with `<leader>O`)
* `<leader>y` and `<leader>p`   -  copy and paste using system clipboard (also `Y` and `P`)
* `jj`                          -  bound to `<Esc>`


Custom Commands
---

* `:VIMRC`    -  open .vimrc in current windoe
* `:SOURCE`   -  source .vimrc
* `:DOS`      -  set file format to dos
* `:UNIX`     -  set file format to unix
* `:MAC`      -  set file format to mac
* `:FILEPATH` -  display the file path in the status line
* `:Ses`      -  set session name for current session

Deploying
---

On Linux and Mac:

    rm -rf .vim
    rm .vimrc
    git clone git@github.com:maciakl/.vim.git
    ln -s .vim/.vimrc .vimrc
    cd .vim
    git submodule init
    git submodule update

On Windows:

    rmdir /s /q vimfiles
    del _vimrc
    git clone git@github.com:maciakl/.vim.git
    mklink /d vimfiles .vim
    mklink /h _vimrc .vim\.vimrc
    cd .vim
    git submodule init
    git submodule update

On Windows XP:

	rmdir /s /q vimfiles
    del _vimrc
    git clone git@github.com:maciakl/.vim.git
    junction vimfiles .vim
    fsutil hardlink create _vimrc .vim\.vimrc
    cd .vim
    git submodule init
    git submodule update

Note that you will need [junction.exe](http://technet.microsoft.com/en-us/sysinternals/bb896768.aspx) from Sysinternals to create the symbolic link for the directory. The fsutil executable should be on your system by default.

Other Prerequisites
-------------------

Your vim should be compiled with `+dialog` and `+python`.

You may also need these:

  - [Exuberant Ctags](http://ctags.sourceforge.net/) 
     
     - On windows download `ctags.exe` and put somewhere in your path
     - On a mac use [Homebrew](http://mxcl.github.com/homebrew/) to install the package ctags. Then add this to `.basrc` or `.profile`
     
    	alias ctags="`brew --prefix`/bin/ctags"

  - [Python 2.7](http://www.python.org/getit/releases/2.7/)


