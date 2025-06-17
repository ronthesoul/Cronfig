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
echo "alias ..='cd .. && ls'" >> ~/.bashrc
echo "alias ...='cd ../.. && ls'" >> ~/.bashrc
echo "alias ....='cd ../../.. && ls'" >> ~/.bashrc
echo "alias home='cd ~ && ls'" >> ~/.bashrc
echo "alias cp='cp -v'" >> ~/.bashrc
echo "alias mv='mv -v'" >> ~/.bashrc
echo "alias brcs='source ~/.bashrc'" >> ~/.bashrc
echo "alias vbr='vim ~/.bashrc'" >> ~/.bashrc

#Memory managment
echo "alias mem='free -m -l -t'" >> ~/.bashrc
echo "alias topmem='ps aux --sort=-%mem | head -10'" >> ~/.bashrc
echo "alias topcpu='ps aux --sort=-%cpu | head -10'" >> ~/.bashrc

#Disk space
echo "alias disk='df -h'" >> ~/.bashrc
echo "alias space='du -sh *'" >> ~/.bashrc

#Networking
echo "alias myip='curl ifconfig.me'" >> ~/.bashrc
echo "alias pingg='ping google.com -c 5'" >> ~/.bashrc
echo "alias ports='ss -tulpn'" >> ~/.bashrc
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
echo "alias cdse='cd /etc/nginx/sites-enabled'" >> ~/.bashrc

#docker commands
echo "alias drad='docker rm $(docker ps -a -q -f "status=exited")'" >> ~/.bashrc
echo "alias drld='docker ps -a -q -f "status=exited"'" >> ~/.bashrc
echo "alias dclean='docker system prune -f'" >> ~/.bashrc
echo "alias dstopall='docker stop $(docker ps -q)'" >> ~/.bashrc
echo "alias dps='docker ps'" >> ~/.bashrc

cat << 'EOF' >> ~/.bashrc
function get_container_ip(){
docker inspect $1 | jq -r '.[0].NetworkSettings.Networks.$1.IPAddress'
}
EOF

cat << 'EOF' >> ~/.bashrc
function create_sandbox(){
malware_volume='/var/sandbox/malware'

if [[ ! -e $malware_volume ]]; then
mkdir -p $malware_volume
fi

docker run -it \
  --rm \
  --cap-drop=ALL \
  --security-opt=no-new-privileges \
  --read-only \
  --network none \
  -v $malware_volume:/malware:ro \
  $1
}
EOF
cat << 'EOF' >> ~/.bashrc
function denter(){
docker exec -it "$1" /bin/bash
}
EOF
cat << 'EOF' >> ~/.bashrc
function dpurge(){
    docker stop $(docker ps -q)
    docker rm $(docker ps -a -q -f "status=exited")
}
EOF

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


#Functions
cat << 'EOF' >> ~/.bashrc 
function change_repo (){
repo_profile=$1
repo_name=$2

git remote add origin git@github.com:$repo_name/$repo_name
git remote set-url origin git@github.com:$repo_profile/$repo_name
}
EOF


cat << EOF >> ~/.bashrc
if [[ ! -e ~/.bashrc_backup ]]; then
    mkdir -p ~/.bashrc_backup
fi

cp ~/.bashrc ~/.bashrc_backup/bashrc
EOF

cat << EOF >> ~/.bashrc
function cl (){
cd $1
ls
}
EOF

cat << 'EOF' >> ~/.bashrc 
function brcs () { 
    local backup_dir="$HOME/.bashrc_backup"
    mkdir -p "$backup_dir"
    if [[ -f "$backup_dir/bashrc_prev" ]]; then
        mv "$backup_dir/bashrc_prev" "$backup_dir/bashrc_prev2"
    fi

    if [[ -f "$HOME/.bashrc" ]]; then
        cp "$HOME/.bashrc" "$backup_dir/bashrc_prev"
    fi

    source "$HOME/.bashrc"
}
EOF

