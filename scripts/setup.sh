#!/bin/bash
sleep 30
set -e
sudo apt-get -y -qq install curl wget git vim apt-transport-https ca-certificates
echo "Setting up NodeJS Environment"
curl https://raw.githubusercontent.com/creationix/nvm/v0.25.0/install.sh | bash
echo 'export NVM_DIR="/home/ubuntu/.nvm"' >> /home/ubuntu/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm' >> /home/ubuntu/.bashrc
# Dot source the files to ensure that variables are available within the current shell
. /home/ubuntu/.nvm/nvm.sh
. /home/ubuntu/.profile
. /home/ubuntu/.bashrc
# Install NVM, NPM, Node.JS & Grunt
nvm alias default 16
nvm install 16
nvm use 16
EOF



chown ubuntu:ubuntu /tmp/setup.sh && chmod a+x /tmp/setup.sh
sleep 1; su - ubuntu -c "/tmp/setup.sh"

