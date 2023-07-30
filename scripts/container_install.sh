#!/bin/bash

function docker_compose_menu() {
  local compose_dir="$1"

  if [ ! -d "$compose_dir" ]; then
    echo "Das Verzeichnis '$compose_dir' existiert nicht oder ist kein Verzeichnis."
    return 1
  fi

  # Zähle die Anzahl der Docker-Compose-Dateien im Verzeichnis
  local compose_files=( "$compose_dir"/*.yml )
  local num_files=${#compose_files[@]}

  if [ "$num_files" -eq 0 ]; then
    echo "Keine Docker-Compose-Dateien im Verzeichnis '$compose_dir' gefunden."
    return 1
  fi

  # Zeige die Anzahl der Dateien und eine Liste der Dateien mit zugehörigen Nummern an
  echo "Es wurden $num_files Docker-Compose-Dateien gefunden:"
  for (( i=0; i<$num_files; i++ )); do
    echo "[$((i+1))] ${compose_files[i]}"
  done

  # Lese die Auswahl des Benutzers ein
  read -p "Geben Sie die Nummer der gewünschten Datei ein (oder 'q' zum Beenden): " choice

  # Überprüfe die Auswahl und führe entsprechende Aktion durch
  case "$choice" in
    [1-$num_files])
      local selected_file="${compose_files[$((choice-1))]}"
      echo "Sie haben '$selected_file' ausgewählt."
      # Führe hier die Aktion aus, die du für die ausgewählte Datei durchführen möchtest.
      # Zum Beispiel: docker-compose up -f "$selected_file"
      ;;
    q|Q)
      echo "Beenden."
      ;;
    *)
      echo "Ungültige Auswahl. Bitte geben Sie eine gültige Nummer ein."
      ;;
  esac
}

#function install_ui() {
#  top_border
#  echo -e "|     ${green}~~~~~~~~~~~ [ Installation Menu ] ~~~~~~~~~~~${white}     |"
#  hr
#  echo -e "|  You need this menu usually only for installing       |"
#  echo -e "|  all necessary dependencies for the various           |"
#  echo -e "|  functions on a completely fresh system.              |"
#  hr
#  echo -e "| Docker:                  | Touchscreen GUI:           |"
#  echo -e "|  1) Docker               |  6) []                     |"
#  echo -e "|  2) Container Install    |                            |"
#  echo -e "|                          | Other:                     |"
#  echo -e "| Text                     |  7) []                     |"
#  echo -e "|  4) []                   |  8) []                     |"
#  echo -e "|                          |  9) []                     |"
#  echo -e "|                          | 10) []                     |"
#  echo -e "|                          | 11) []                     |"
#  echo -e "| Gruppenname:             |                            |"
#  echo -e "|  5) []                   | Gruppenname:               |"
#  echo -e "|                          | 12) [Crowsnest]            |"
#  back_footer
#}

#function install_menu() {
#  clear -x && sudo -v && clear -x # (re)cache sudo credentials so password prompt doesn't bork ui
#  print_header
#  install_ui
#  local action
#  while true; do
#    read -p "${cyan}####### Perform action:${white} " action
#    case "${action}" in
#      1)
#        do_action "start_docker_setup" "install_ui";;
#      2)
#        container_install;;
#      4)
#        do_action "install_mainsail" "install_ui";;
#      5)
#        do_action "install_fluidd" "install_ui";;
#      6)
#        do_action "octoprint_setup_dialog" "install_ui";;
#      7)
#        do_action "install_pgc_for_klipper" "install_ui";;
#      8)
#        do_action "telegram_bot_setup_dialog" "install_ui";;
#      9)
#        do_action "moonraker_obico_setup_dialog" "install_ui";;
#      10)
#        do_action "octoeverywhere_setup_dialog" "install_ui";;
#      11)
#        do_action "install_mobileraker" "install_ui";;
#      12)
#        do_action "install_crowsnest" "install_ui";;
#      B|b)
#        clear; main_menu; break;;
####"#     ###"" *)"##
#        deny_action "install_ui";;
#    esac
#  done
#  install_menu
#}

# Starte das Menü, wenn das Skript direkt aufgerufen wird
if [ "${0}" = "${BASH_SOURCE}" ]; then
  install_menu
fi
