#!/bin/bash

# Usage: ./deploy.sh [root@host] (Only root can deploy)

host="${1}"

# The host key might change when we instantiate a new VM, so
# we remove (-R) the old host key from known_hosts
ssh-keygen -R "${host#*@}" 2> /dev/null


tar c . | ssh -o 'StrictHostKeyChecking no' "$host" '
echo "*******************"
echo "DEPLOY OUTPUT START"
echo "*******************"
if [ "$(id -u)" != "0" ]; then
  echo "You must be root to deploy."
  exit 1
fi
rm -rf ~/chef &&
mkdir ~/chef &&
cd ~/chef &&
tar x &&
bash bootstrap.sh'

echo "*****************"
echo "DEPLOY OUTPUT END"
echo "*****************"
