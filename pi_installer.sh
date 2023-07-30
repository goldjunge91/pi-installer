#!/usr/bin/env bash

set -e
clear

### sourcing all additional scripts
PFAD="$(dirname -- "$(readlink -f "${BASH_SOURCE[0]}")")"
for script in "${PFAD}/scripts/"*.sh; do . "${script}"; done
for script in "${PFAD}/scripts/ui/"*.sh; do . "${script}"; done
#===================================================#
#=================== KIAUH STATUS ==================#
#===================================================#

function check_installed_software() {
    # Hier können Sie die Befehle hinzufügen, um zu überprüfen, welche Software bereits installiert ist
    # Speichern Sie die Ergebnisse in einer Datei oder einer Umgebungsvariablen, um sie später im Menü anzuzeigen
    :
}

check_euid
init_logfile
check_installed_software
set_globals
main_menu