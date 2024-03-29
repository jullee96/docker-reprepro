#!/usr/bin/env bash

echo "ENTRYPOINT start..."
echo "entrypoint - repo name :  $REPO_ENV_NAME"
mkdir /tmp/repo-keys/

echo "setup key....$REPO_ENV_NAME"

cat <<EOF | gpg1 --homedir /tmp/repo-keys --batch --gen-key
%echo Generating a basic OpenPGP key
Key-Type: RSA
Key-Length: 4096
Subkey-Type: RSA
Subkey-Length: 4096
Name-Real: $REPO_ENV_NAME
Name-Email: bono6315@gmail.com
Passphrase: password
Expire-Date: 0
%commit
%echo done
EOF
gpg1 --homedir /tmp/repo-keys --list-secret-keys --keyid-format LONG
GPG_KEY_ID=$(gpg1 --homedir /tmp/repo-keys --list-secret-keys --keyid-format LONG | awk '/sec/'  | grep "4096R" | sed "s/.*\/\([^ ]*\).*/\1/")

echo "Exporting key: ${GPG_KEY_ID}"
gpg1 --homedir /tmp/repo-keys --armor --output $REPO_ENV_NAME.pubkey.gpg --export ${GPG_KEY_ID} 
chown 700:700 $REPO_ENV_NAME.pubkey.gpg

chmod 700 /repo/gnupg /root/.gnupg && chown -R root:root /root/.gnupg /repo/gnupg
sed -i "s/YOUR_GPG_KEY_ID/$GPG_KEY_ID/g" /repo/conf/distributions
sed -i "s/YOUR_GPG_KEY_ID/$GPG_KEY_ID/g" /repo/gnupg/gpg_sign_key_id
sed -i "s/YOUR_REPO_NAME/$REPO_NAME/g" /repo/conf/distributions
sed -i "s/YOUR_REPO_NAME/$REPO_NAME/g" /repo/conf/incoming

cp /tmp/repo-keys/* /repo/gnupg
cp $REPO_ENV_NAME.pubkey.gpg /repo/public/

