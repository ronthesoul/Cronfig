#!/usr/bin/env bash
#########################################
#Developed by: Ron Negrov
#Purpose: A script that adds all my required features to bashrc
#Date: 24.2.2025
#Version: 0.0.4
##########################################

#Adds my custom PS1 to bashrc
PS1_VALUE='PS1='\''\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;33m\]$(git rev-parse --abbrev-ref HEAD 2>/dev/null | sed "s/\(.*\)/ [\1]/")\[\033[00m\]\n$ '\'''
echo "$PS1_VALUE" >> ~/.bashrc

#System configs
echo "Lazarus" > /etc/hostname 2>&1



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
echo "alias bigfiles='find . -type f -exec du -h {} + | sort -rh | head -10'" >> ~/.bashrc

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

#nginx commands
echo "alias nxs='service nginx status'" >> ~/.bashrc
echo "alias nxr='service nginx restart'" >> ~/.bashrc
echo "alias nxstart='service nginx start'" >> ~/.bashrc
echo "alias nxstop='service nginx stop'" >> ~/.bashrc




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

syntax on
set completeopt=menuone,noselect

" Save and Quit shortcuts
nnoremap <C-s> :w<CR>
nnoremap <C-q> :wq<CR>

" Copy Paste shortcuts
vnoremap <C-c> "+y
nnoremap <C-p> "+p
inoremap <C-p> <C-r>+
cnoremap <C-p> <C-r>+
tnoremap <C-p> <C-r>+

" Map ctrl left and right to move between tabs
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-Left> :tabprev<CR>


set termguicolors
colorscheme github
EOF


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
