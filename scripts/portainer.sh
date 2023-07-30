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

function install_portainer {
    # Portainer installieren
    sudo docker pull portainer/portainer-ce:latest || error "Fehler beim Herunterladen des neuesten Portainer-Docker-Images!"
    # Überprüfung, ob das Portainer-Docker-Image erfolgreich heruntergeladen wurde
    if sudo docker image inspect portainer/portainer-ce:latest &>/dev/null; then
        echo "Portainer wurde erfolgreich heruntergeladen."
    else
        error "Fehler beim Herunterladen von Portainer!"
    fi
}

function deploy_portainer {
    # Portainer deployen
    sudo docker run -d -p 9000:9000 -p 9443:9443 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest --logo "https://pi-hosted.com/pi-hosted-logo.png" || error "Fehler beim Deployen des Portainer-Docker-Images!"
    # Überprüfung, ob Portainer erfolgreich deployed wurde
    if sudo docker ps | grep portainer &>/dev/null; then
        echo "Portainer wurde erfolgreich deployed und läuft."
    else
        error "Fehler beim Deployen von Portainer!"
    fi
}

function call_portainer_with_timer() {
    # Hier wird der Timer von 10 Sekunden gestartet
    countdown_timer 3
    # Hier wird install_portainer() aufgerufen
    install_portainer
    countdown_timer 3
    deploy_portainer
}

