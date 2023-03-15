#/bin/sh
DIR_PATH="$(pwd)"
echo "DIR_PATH : $DIR_PATH" 
# If don't have ssh key then, generate ssh key
if [ "$1" = "--gen-ssh-key" ]; then
    sudo apt install 
    cd ~/.ssh
    ssh-keygen -b 2048 -t rsa -f ssh_host_rsa_key -q -N ""
    cp ssh_host_* $DIR_PATH/repo/ssh/
    cd $DIR_PATH/repo/ssh/
    cp ssh_host_rsa_key.pub authorized_keys
    cd ../..
fi

# docker execute
docker-compose up -d

# add apt gpg key && repo
# wget -qO - http://192.168.0.31/jullee.pubkey.gpg | sudo apt-key add -
# echo "deb [arch=amd64] http://192.168.0.31 jullee main" | sudo tee /etc/apt/sources.list.d/hamonize.list
# sudo apt-get update 


