#!/bin/bash

DIR_PATH="$(pwd)"
echo "DIR_PATH : $DIR_PATH" 
# If don't have ssh key then, generate ssh key
if [ "$1" = "--gen-ssh-key" ]; then
    cd ~/.ssh
    yes | ssh-keygen -b 2048 -t rsa -f ssh_host_rsa_key -q -N ""
    cp ssh_host_* $DIR_PATH/repo/ssh/
    cd $DIR_PATH/repo/ssh/
    cp ssh_host_rsa_key.pub authorized_keys
    cd ../..

    IFS='=' read -r -a args <<< "$2"

    # docker execute
    docker-compose build --build-arg REPO_NAME="${args[1]}" && docker-compose up

else
    IFS='=' read -r -a args <<< "$1"
    # docker execute
    docker-compose build --build-arg REPO_NAME="${args[1]}" && docker-compose up

fi

# add apt gpg key && repo
# wget -qO - http://192.168.0.31/$REPO_NAME.pubkey.gpg | sudo apt-key add -
# echo "deb [arch=amd64] http://192.168.0.31 $REPO_NAME main" | sudo tee /etc/apt/sources.list.d/$REPO_NAME.list
# sudo apt-get update 


