#!/bin/bash

function find_docker_compose_files() {
    local compose_dir="/mnt/c/Users/tozzi/Github/pi-installer/scripts/container"
    
    # Überprüfen, ob das Verzeichnis existiert
    if [ ! -d "$compose_dir" ]; then
        echo "Das Verzeichnis '$compose_dir' existiert nicht oder ist kein Verzeichnis."
        return 1
    fi
    
    # Suche nach Docker-Compose-Dateien im Verzeichnis
    local compose_files=( "$compose_dir"/*.yml )
    
    # Überprüfen, ob Docker-Compose-Dateien gefunden wurden
    if [ ${#compose_files[@]} -eq 1 ] && [ ! -f "${compose_files[0]}" ]; then
        echo "Keine Docker-Compose-Dateien im Verzeichnis '$compose_dir' gefunden."
        return 1
    fi
    
    # Gebe die gefundenen Dateien zurück
    echo "${compose_files[@]}"
}

function container_install_ui() {
    top_border
    echo -e "|  ${green}~~~~~~~~~~~ [ Container Install Menu ] ~~~~~~~~~~~${white}   |"
    hr
    echo -e "|  This menu allows you to install Docker containers    |"
    echo -e "|  based on Docker Compose files found in the           |"
    echo -e "|  specified directory.                                 |"
    hr
    echo -e "|  Docker Compose Files:                                |"
    
    local compose_files=$(find_docker_compose_files)
    if [ -z "$compose_files" ]; then
        echo "Keine Docker-Compose-Dateien gefunden."
        return 1
    fi
    
    local num=1
    for file in $compose_files; do
        # Entferne den Pfad, die Dateierweiterung und den "docker-compose-" Teil des Dateinamens
        local filename=$(basename "$file" .yml | sed 's/docker-compose-//')
        # Beschränke die Ausgabe auf 57 Zeichen und füge am Ende ein "|"
        printf "|  %2d) %-48s |\n" $num "$filename"
        ((num++))
    done
    
    back/close_footer
}

function container_install_menu() {
    while true; do
        clear && print_header
        container_install_ui || return 1 # Wenn keine Docker-Compose-Dateien gefunden wurden, gehe zurück zum Hauptmenü
        local action
        read -p "${cyan}####### Perform action:${white} " action
        case "${action}" in
            B|b)
            clear; main_menu; break;;
            Q|q)
                echo -e "${red}###### Exiting! ######${reset}"; echo
            exit 0;;
            *)
                selected_file=$(find_docker_compose_files | head -n $action | tail -n 1)
                if [ -z "$selected_file" ]; then
                    echo "Ungültige Auswahl. Bitte geben Sie eine gültige Nummer ein."
                else
                    echo "Sie haben '$selected_file' ausgewählt."
                    # Führe hier die Aktion aus, die du für die ausgewählte Datei durchführen möchtest.
                    # Zum Beispiel: docker-compose -f "$selected_file" up -d
                fi
                read -p "Drücken Sie eine beliebige Taste, um fortzufahren..." # Warte auf eine Eingabe, bevor das Menü erneut geladen wird
            ;;
        esac
    done
}

# Start the menu if the script is called directly
if [ "${0}" = "${BASH_SOURCE}" ]; then
    container_install_menu
fi
