My Personal Vim Directory
===

This is my personal git directory, under source control ready to be deployed
across across all platforms.

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
===================

You may also need these:

  - [Exuberant Ctags](http://ctags.sourceforge.net/) 
     
     - On windows download `ctags.exe` and put somewhere in your path
     - On a mac use [Homebrew](http://mxcl.github.com/homebrew/) to install the package ctags. Then add this to `.basrc` or `.profile`
     
    	alias ctags="`brew --prefix`/bin/ctags"

  - [Python 2.7](http://www.python.org/getit/releases/2.7/)


