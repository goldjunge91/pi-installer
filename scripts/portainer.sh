#!/bin/bash

function error {
  echo -e "\\e[91m$1\\e[39m"
  exit 1
}

function countdown_timer {
    local seconds=$1
    while [ $seconds -gt 0 ]; do
        echo -ne "Verbleibende Zeit: $seconds Sekunden\033[0K\r"
        sleep 1
        ((seconds--))
    done
    echo -e "\033[0K" # Löscht die Ausgabe der verbleibenden Zeit
}

sudo docker pull portainer/portainer-ce:latest || error "Failed to pull latest Portainer docker image!"
countdown_timer 3
sudo docker run -d -p 9000:9000 -p 9443:9443 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest --logo "https://pi-hosted.com/pi-hosted-logo.png" || error "Failed to run Portainer docker image!"
