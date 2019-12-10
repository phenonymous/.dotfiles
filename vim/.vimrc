set nocompatible

filetype off

set rtp+=$VIMDOTDIR/bundle/Vundle.vim
set rtp+=$ZDOTDIR/lib/fzf

call vundle#begin("$VIMDOTDIR/bundle")

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdtree-git-plugin'
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'ryanoasis/vim-devicons'
Plugin 'srcery-colors/srcery-vim'

call vundle#end()

map <C-n> :NERDTreeToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

set laststatus=2        "" set ls=2
set showtabline=2       "" set stal=2
set noshowmode          "" set nosmd
set t_Co=256
set encoding=utf-8      "" set enc=utf-8
set fileencoding=utf-8  "" set fenc=utf-8
set tabstop=2           "" set ts=2
set shiftwidth=2        "" set sw=2
set softtabstop=2       "" set sts=2
set expandtab           "" set et
set number              "" set nu
set autoread            "" set ar

syntax on
filetype plugin indent on

colorscheme srcery
