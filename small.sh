#!/bin/sh
sudo curl https://api.github.com/repos/docker/compose/releases/latest -o output.json 
version=grep -m 1 -oP '(?<="name": ")[^"]*' output.json 
echo "${version#v}"