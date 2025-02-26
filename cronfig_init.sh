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


#bin aliases
echo "alias ..='cd ..'" >> ~/.bashrc
echo "alias ...='cd ../..'" >> ~/.bashrc
echo "alias ....='cd ../../..'" >> ~/.bashrc
echo "alias home='cd ~'" >> ~/.bashrc
echo "alias cp='cp -v'" >> ~/.bashrc
echo "alias mv='mv -v'" >> ~/.bashrc

#Memory managment
echo "alias mem='free -m -l -t'" >> ~/.bashrc
echo "alias topmem='ps aux --sort=-%mem | head -10'" >> ~/.bashrc
echo "alias topcpu='ps aux --sort=-%cpu | head -10''" >> ~/.bashrc

#Disk space
echo "alias disk='df -h'" >> ~/.bashrc
echo "alias space='du -sh *'" >> ~/.bashrc
echo "alias bigfiles='find . -type f -exec du -h {} + | sort -rh | head -10'" >> ~/.bashrc

#Networking
echo "alias myip='curl ifconfig.me'" >> ~/.bashrc
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
