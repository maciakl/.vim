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
    ln -s .vimrc .vim/.vimrc
    cd .vim
    git submodule init
    git submodule update

On Windows:

    rmdir /s /q vimfiles
    del _vimrc
    git clone git@github.com:maciakl/.vim.git
    mklink /d vimfiles .vim
    mklink _vimrc .vim\.vimrc
    cd .vim
    git submodule init
    git submodule update

