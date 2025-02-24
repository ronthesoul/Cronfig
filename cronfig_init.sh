#!/usr/bin/env bash
#########################################
#Developed by: Ron Negrov
#Purpose: A script that adds all my required features to bashrc
#Date: 24.2.2025
#Version: 0.0.1
##########################################

#cd aliases
echo "alias ..='cd ..'" >> ~/.bashrc
echo "alias ...='cd ../..'" >> ~/.bashrc
echo "alias ....='cd ../../..'" >> ~/.bashrc
echo "alias home='cd ~'" >> ~/.bashrc

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



source ~/.bashrc



