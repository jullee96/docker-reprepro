## docker-reprepro 

This program can simply make your own individual APT repository using a docker.



#### build environment

- docker : v20.10.7
- docker-compose : v1.29.2



### quick start

If you don't have a sh key, start with the command below.

```
./create-apt.sh --gen-ssh-key --repo={my-repo-name}
```



If you have a sh key, start with the command below.

```
./create-apt.sh --repo={my-repo-name}
```


### for custom os
```
wget -qO - http://{your ip}/{$REPO_NAME}.pubkey.gpg | apt-key add -
```
