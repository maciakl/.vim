My Personal Vim Directory
===

This is my personal git directory, under source control ready to be deployed
across across all platforms.

Deploying
---

On Linux and Mac:

    rm -rf .vim
    rm .vimrc
    git clone git@github.com:maciakl/fofou.git
    ln -s .vimrc .vim/.vimrc

On Windows:

    rmdir /s /q vimfiles
    del _vimrc
    git clone path/to/your/.vim.git
    mklink /d vimfiles .vim
    mklink _vimrc .vim\.vimrc


