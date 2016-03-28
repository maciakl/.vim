My Personal Vim Settings
===

This is my personal git directory, under source control ready to be deployed
across across all platforms.

Sessions
--------

Sessions are automatically saved to `~/.vim/session` and you will be asked if 
you want to restore from an existing session if you open vim without a file
argument. Session names are created based on the `--servername` argument. The
default for gvim is `GVIM`. If you want to create a unique session you can do:

    :SessionName sessionname

Then launch vim with that session name to restore:

    gvim --servername sessioname

Note that sessions preserve environment. If you updated `.vimrc` or plugins you
will need to manually source them after launching. If your session just got 
weird, you can blow away everything other than the buffer and tab list by doing:

    :SessionCleanSave

This is the same as setting:

    :set sessionoptions=blank,buffers,curdir,tabpages

Then quit and re-launch to clean environment with the buffer list and arglist
intact.

Persistent Undo
---------------

Persistent undo is enabled if you are running 7.3 or above. All the undo files
are saved to `~/.vim/undo`. This directory may get somewhat large if you don't
blow it away every once in a while so watch for that.

Plugins
---

These are the custom plugins I use:

* [Closetag.vim](https://github.com/vim-scripts/closetag.vim) - use `<c-_>` close HTML tags
* [Emmet.vim](https://github.com/mattn/emmet-vim) - automated expansion for html and css
* [Gundo](https://github.com/sjl/gundo.vim) - browse the undo tree in the sidebar
* [NERDcommenter](https://github.com/scrooloose/nerdcommenter) - auto-commenting
* [ObviousMode](https://github.com/bsl/obviousmode) - change color of sidebar depending on mode
* [PHPDocumentator](https://github.com/vim-scripts/PDV--phpDocumentor-for-Vim) - generate PHPDoc comments
* [SnipMate](https://github.com/msanders/snipmate.vim) - auto-complete code snippets
* [Tabular](https://github.com/godlygeek/tabular) - auto-align code chunks
* [TagList](https://github.com/vim-scripts/taglist.vim) - browse the tag list
* [Tex-AutoClose](https://github.com/vim-scripts/tex_autoclose.vim) - auto close tex environments
* [Unite.vim](https://github.com/Shougo/unite.vim) - file/buffer/history browsing
* [Vim-Align](https://github.com/tsaleh/vim-align) - auto-align code chunks (like Tabular)
* [Vim-AutoClose](https://github.com/Townk/vim-autoclose) - auto close parens and brackets
* [Vim-Coffee-Script](https://github.com/kchmck/vim-coffee-script) - Coffeescript syntax highlighting and helpers
* [Vim-Fugitive](https://github.com/tpope/vim-fugitive) - git integration
* [Vim-Git](https://github.com/tpope/vim-git) - runtime rules for git commit, gitignore and etc..
* [Vim-Markdown](https://github.com/plasticboy/vim-markdown) - syntax highlighting and matching rules for Markdown.
* [Vim-Rails](https://github.com/tpope/vim-rails) - ruby on rails integration and commands
* [Vim-SuperTab](https://github.com/tsaleh/vim-supertab) - super-charge the tab key
* [Vim-indent-object](https://github.com/michaeljsmith/vim-indent-object) - text object for Python indent block
* [Vim-liquid](https://github.com/tpope/vim-liquid) - support for Liquid with Jekyll extensions for blogging.
* [Vim-matchit](https://github.com/edsono/vim-matchit) - skip to closing HTML tag with `%`
* [Vim-neatstatus](https://github.com/maciakl/vim-neatstatus) - simple status line with colors
* [Vim-ruby-sinatra](https://github.com/hallison/vim-ruby-sinatra) - syntax and snippets for sinatra framework
* [Vim-signature](https://github.com/kshenoy/vim-signature) - easy navigation with marks (displays in gutter)
* [Vim-surround](https://github.com/tpope/vim-surround) - bindings to easily surround text with stuff

Custom Key Bindings
---

The `<leader>` key is bound to `<space>` because space is cool.

* `+` and `-`                   -  increment and decrement number under cursor
* `<C-BS>`                      -  ctrl+backspace deletes last word
* `<C-Del>`                     -  ctrl+Del deletes next word
* `<C-F>`                       -  opens the file under cursor in the 2nd split window if open
* `<C-L>`                       -  fix last typo
* `<C-P>`                       -  generate PHPDoc comments at cursor (defined in `ftplugin/php.vim`)
* `<C-R>`                       -  paste in contents of the unnamed register
* `<C-Tab>`                     -  toggle between splits
* `<C-_>`                       -  close html tag (closetag.vim) or tex environment (tex-autoclose.vim)
* `<Down>`                      -  search current directory for files with Unite
* `<F10>`                       -  insert current date at cursor
* `<F2>`                        -  toggle Tag List buffer
* `<F3>`                        -  toggle paste mode
* `<F5>`                        -  toggle relative and absolute line numbering
* `<F7>`                        -  toggle Gundo undo browser
* `<Left>` and `<Right>`        -  browse through buffers
* `<S-Tab>`                     -  Auto expand and/or jump when using Emmet plugin
* `<Tab>`                       -  next buffer
* `<Up>`                        -  search/display open buffers with Unite
* `<leader><cr>`                -  break line at cursor (normal mode)
* `<leader><space>`             -  clear search highlights (double tap `<space>`)
* `<leader>H` and `<leader>h`   -  markdown headings (defined in `ftplugin/mkd.vim`)
* `<leader>o`                   -  insert a blank line (normal mode) (also works with `<leader>O`)
* `<leader>y` and `<leader>p`   -  copy and paste using system clipboard (also `Y` and `P`)
* `jj`                          -  bound to `<Esc>`
* `m<space>`                    -  delete all marks in the document


Custom Commands
---

* `:VIMRC`                  - open .vimrc in current windows
* `:SOURCE`                 - source .vimrc
* `:DOS`                    - set file format to dos
* `:UNIX`                   - set file format to unix
* `:MAC`                    - set file format to mac
* `:FILEPATH`               - display the file path in the status line
* `:CTAGS`                  -  run `ctags` recursively on project directory
* `:SessionName`            - set session name for current session
* `:SessionSaveBuffersOnly` - save only buffers on exit (same as `set ssop=buffers,args`)
* `:SPCLEAN`                - runs cleanup routine on spell-check files
* `:RemoveEm`               - remove the `^M` symbols from the file

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

- [Python 2.7](http://www.python.org/getit/releases/2.7/)
- [Exuberant Ctags](http://ctags.sourceforge.net/) 

You could probably use unix ctags, but they don't have all the features.

####CTAGS Ain't Hard!

On debians and buntus of all shapes and sizes:

    sudo apt-get install exuberant-ctags
     
On windows download `ctags.exe` from the link above and put somewhere in your path.

Mac is a little trickier:

- Use [Homebrew](http://mxcl.github.com/homebrew/) to install the package ctags. 
    
Then add this to `.basrc` or `.profile`:

    alias ctags="`brew --prefix`/bin/ctags"
