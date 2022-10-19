#!/bin/sh

sleep 30
set -o errexit
set -o nounset

IFS=$(printf '\n\t')

# Add Nginx
sudo apt install nginx -y
systemctl status nginx
printf '\nNginx installed successfully\n\n'

# Certbot
sudo snap install core; sudo snap refresh core
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
printf '\nCertbot installed successfully\n\n'


# Docker
sudo apt update
sudo apt install -y curl
curl -fsSL https://get.docker.com -o get-docker.sh
sudo chmod 777 get-docker.sh
sh get-docker.sh
printf '\nDocker installed successfully\n\n'

sleep 5
# Adding Docker to group 
sudo usermod -aG docker ${USER}
sudo docker version

# # Docker Compose
sudo curl https://api.github.com/repos/docker/compose/releases/latest -o output.json 
version=$(grep -m 1 -oP '(?<="name": ")[^"]*' output.json )
echo "${version}"
sudo curl -L "https://github.com/docker/compose/releases/download/${version}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
printf '\nDocker Compose  installed successfully\n\n'
