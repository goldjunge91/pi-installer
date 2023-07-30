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



#curl -sSL https://get.docker.com | sh || error "Failed to install Docker."
#countdown_timer 3
#sudo usermod -aG docker $USER || error "Failed to add user to the Docker usergroup."
#echo "Remember to logoff/reboot for the changes to take effect."

function install_docker {
    # Installation von Docker
    curl -sSL https://get.docker.com | sh || error "Failed to install Docker."
    countdown_timer 3
    
    # Überprüfung, ob Docker erfolgreich installiert wurde
    if command -v docker &> /dev/null; then
        DOCKER_VERSION=$(docker --version | cut -d ' ' -f 3)
        echo "Docker wurde erfolgreich installiert, Version: $DOCKER_VERSION"
    else
        error "Fehler bei der Installation von Docker!"
    fi
    countdown_timer 3
    sudo usermod -aG docker $USER || error "Failed to add user to the Docker usergroup."
    echo "Remember to logoff/reboot for the changes to take effect."
}