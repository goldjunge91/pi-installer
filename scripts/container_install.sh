#!/usr/bin/env bash
# Laden der Variable DOCKER_COMPOSE_DIR aus file.sh
#DOCKER_COMPOSE_DIR="/mnt/c/Users/tozzi/Github/pi-installer/scripts/container"

# Pfad zum Docker-Compose-Verzeichnis
#DOCKER_COMPOSE_DIR

# Funktion zum Auflisten und Auswählen von Docker-Compose-Dateien
function select_docker_compose_file() {
  # Erstellen Sie ein Array mit Docker-Compose-Dateien
  IFS=$'\n' files=($(ls -1 "$DOCKER_COMPOSE_DIR"/*.yml))

  # Überprüfen Sie, ob Dateien gefunden wurden
  if [ ${#files[@]} -eq 0 ]; then
    echo "Keine Docker-Compose-Dateien gefunden!"
    return
  fi

  # Erstellen Sie ein Menü mit den gefundenen Dateien
  echo "Wählen Sie eine Docker-Compose-Datei aus:"
  select file in "${files[@]}"; do
    if [ -n "$file" ]; then
      echo "Sie haben die Datei $file ausgewählt."
      # Führen Sie hier den Docker-Compose-Befehl aus
      # docker-compose -f "$file" up -d
      break
    else
      echo "Ungültige Auswahl!"
    fi
  done
}

function container_install_menu() {
  clear && print_header
  echo -e "|     ${cyan}~~~~~~~~~~~~~~~ [ Container Install Menu ] ~~~~~~~~~~~~~~~${reset}     |"
  hr
  # Aufrufen der Funktion zum Auswählen der Docker-Compose-Datei
  select_docker_compose_file
  bottom_border
  echo -e "|                       ${green}B) « Back${white}                       |"
  echo -e "|                       ${green}C) « Cancel${white}                     |"
  bottom_border
  local action
  while true; do
    read -p "${cyan}####### Perform action:${white} " action
    case "${action}" in
      B|b)
        # Zurück zum Hauptmenü
        main_menu
        break;;
      C|c)
        # Auswahl abbrechen
        echo "Auswahl abgebrochen"
        break;;
      *)
        echo "Ungültige Auswahl!"
    esac
  done
}
