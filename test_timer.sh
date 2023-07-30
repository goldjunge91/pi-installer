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

echo "printhell" || error "Failed to pull latest Portainer docker image!"

# Hier wird der Timer von 10 Sekunden gestartet
countdown_timer 3

echo "hell welt 10"
