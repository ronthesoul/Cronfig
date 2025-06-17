#!/usr/bin/env bash
#########################################
#Developed by: Ron Negrov
#Purpose: A script that adds all my required features to bashrc
#Date: 24.2.2025
#Version: 0.0.9
##########################################

cat << 'EOF' 
####################################################################
______ .______        ______   .__   __.  _______  __    _______ 
 /      ||   _  \      /  __  \  |  \ |  | |   ____||  |  /  _____|
|  ,----'|  |_)  |    |  |  |  | |   \|  | |  |__   |  | |  |  __  
|  |     |      /     |  |  |  | |  . `  | |   __|  |  | |  | |_ | 
|  `----.|  |\  \----.|  `--'  | |  |\   | |  |     |  | |  |__| | 
 \______|| _| `._____| \______/  |__| \__| |__|     |__|  \______| 
####################################################################
EOF
                                                                   


#Adds my custom PS1 to bashrc
PS1_VALUE='PS1='\''\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;33m\]$(git rev-parse --abbrev-ref HEAD 2>/dev/null | sed "s/\(.*\)/ [\1]/")\[\033[00m\]\n$ '\'''
echo "$PS1_VALUE" >> ~/.bashrc


#Vim configs

if ! dpkg -l | grep -q "^ii  vim "; then
    sudo apt install -y vim
fi

if ! dpkg -l | grep -q "^ii  vim-gtk3 "; then
    sudo apt install vim-gtk3 -y
fi

echo 'export EDITOR=vim' >> ~/.bashrc

mkdir -p ~/.vim/colors
curl -o ~/.vim/colors/molokai.vim https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cat << 'EOF' >> ~/.vimrc
set number
set mouse=a
set tabstop=4
set shiftwidth=4
set expandtab
set showtabline=1
set clipboard=unnamedplus  
set incsearch
set hlsearch
set ruler
set showcmd
set wildmenu
set showmatch
let mapleader=" "

syntax on
set completeopt=menuone,noselect

" Save and Quit shortcuts
nnoremap <leader>s :w<CR>      " Save file
nnoremap <leader>q :wq<CR>     " Save and quit
nnoremap <leader>x :q!<CR>     " Quit without saving

" Copy Paste shortcuts
nnoremap <leader>c "+y   " Copy in normal mode
vnoremap <leader>c "+y   " Copy in visual mode
vnoremap <C-c> "+y
nnoremap <C-c> "+y

nnoremap <C-p> "+p
inoremap <C-p> <C-r>+
cnoremap <C-p> <C-r>+
tnoremap <C-p> <C-r>+
nnoremap <leader>v "+p   " Paste after cursor
nnoremap <leader>V "+P   " Paste before cursor
inoremap <leader>v <C-r>+   " Paste in insert mode
cnoremap <leader>v <C-r>+   " Paste in command mode
tnoremap <leader>v <C-r>+   " Paste in terminal mode

" Map ctrl left and right to move between tabs
nnoremap <C-S-Right> :tabnext<CR>
nnoremap <C-S-Left> :tabprev<CR>
nnoremap <C-t> :vertical terminal<CR>
nnoremap <leader>r :%s//g<Left><Left>

"  Adding plugins 
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'vim-test/vim-test'
Plug 'puremourning/vimspector'
Plug 'mbbill/undotree' 

call plug#end()

set termguicolors
colorscheme molokai
EOF

#Changing background color
git clone https://github.com/chriskempson/base16-shell.git ~/.base16config/base16-shell

cat << 'EOF' >> ~/.bashrc
# Base16 Shell
BASE16_SHELL="$HOME/.base16config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")" 

EOF
chmod +x ~/.base16config/base16-shell/scripts/base16-default-dark.sh
echo 'source ~/.base16config/base16-shell/scripts/base16-default-dark.sh' >> ~/.bashrc


curl -o alias_bashrc https://raw.githubusercontent.com/ronthesoul/Cronfig/main/new_config/alias_bashrc
curl -o _func_bashrc https://raw.githubusercontent.com/ronthesoul/Cronfig/main/new_config/_func_bashrc
source "$HOME/.alias_bashrc"
source "$HOME/.func_bashrc"