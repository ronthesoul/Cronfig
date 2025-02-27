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



#bin aliases
echo "alias ..='cd ..'" >> ~/.bashrc
echo "alias ...='cd ../..'" >> ~/.bashrc
echo "alias ....='cd ../../..'" >> ~/.bashrc
echo "alias home='cd ~'" >> ~/.bashrc
echo "alias cp='cp -v'" >> ~/.bashrc
echo "alias mv='mv -v'" >> ~/.bashrc
echo "alias brcs='source ~/.bashrc'" >> ~/.bashrc

#Memory managment
echo "alias mem='free -m -l -t'" >> ~/.bashrc
echo "alias topmem='ps aux --sort=-%mem | head -10'" >> ~/.bashrc
echo "alias topcpu='ps aux --sort=-%cpu | head -10''" >> ~/.bashrc

#Disk space
echo "alias disk='df -h'" >> ~/.bashrc
echo "alias space='du -sh *'" >> ~/.bashrc

#Networking
echo "alias myip='curl ifconfig.me && echo ""'" >> ~/.bashrc
echo "alias pingg='ping google.com -c 5'" >> ~/.bashrc
echo "alias ports='netstat -tulnp'" >> ~/.bashrc
echo "alias ipc='ip -br -c  addr'" >> ~/.bashrc
echo "alias ipd='ip route show default'" >> ~/.bashrc
echo "alias ipn='cat /etc/resolv.conf | grep nameserver'" >> ~/.bashrc

#Git 
echo "alias gl='git log --oneline --graph --decorate --all'" >> ~/.bashrc
echo "alias gr='git remote -v'" >> ~/.bashrc
echo "alias gpf='git fetch origin && git pull --rebase'" >> ~/.bashrc
echo "alias gp='git push -u'" >> ~/.bashrc
echo "alias gitcon='ssh -T git@github.com'" >> ~/.bashrc
echo "alias gc='git commit'" >> ~/.bashrc
echo "alias ga='git add'" >> ~/.bashrc
echo "alias gb='git branch'" >> ~/.bashrc
echo "alias gs='git status'" >> ~/.bashrc

#nginx commands
echo "alias nxs='service nginx status'" >> ~/.bashrc
echo "alias nxr='sudo service nginx restart'" >> ~/.bashrc
echo "alias nxstart='sudo service nginx start'" >> ~/.bashrc
echo "alias nxstop='sudo service nginx stop'" >> ~/.bashrc




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


#Functions
cat << 'EOF' >> ~/.bashrc
change_git_repo() {
    github_user=$1
    github_repo=$2
    if [[ $# -ne 2 || -z "$github_user" || -z "$github_repo" ]]; then
        echo "Usage: change_git_repo <github_user> <github_repo>"
        return 1
    fi
    if git remote add origin git@github.com:$github_user/$github_repo.git; then
        echo "Changed the pointer to $github_user/$github_repo"
        return 0
    else
        echo "Failed to add a pointer"
        return 1
    fi
}
EOF
