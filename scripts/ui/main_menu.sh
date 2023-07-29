#!/usr/bin/env bash

set -e

# Placeholder functions
function new_install_menu() {
  echo "New Install Menu"
}

function container_install_menu() {
  source "/mnt/c/Users/tozzi/Github/pi-installer/scripts/container_install.sh"
}

function program_install_menu() {
  echo "Program Install Menu"
}

function repair_menu() {
  echo "Repair Menu"
}

function update_options_menu() {
  echo "Update Options Menu"
}

function main_ui() {
  top_border
  echo -e "|     $(title_msg "~~~~~~~~~~~~~~~ [ Main Menu ] ~~~~~~~~~~~~~~~")     |"
  hr
  echo -e "| 1) Docker            |  docker: $(print_status "docker")    |"
  echo -e "|                      |                                |"
  echo -e "| 2) Container Install |                                |"
  echo -e "|                      |                                |"
  echo -e "| 3) Program Install   |                                |"
  echo -e "|                      |                                |"
  echo -e "| 4) Repair            |                                |"
  echo -e "|                      |                                |"
  echo -e "| 5) Update Options    |                                |"
  hr
  blank_line
  quit_footer
}

function print_status() {
  local status component="${1}"
  status=$(get_"${component}"_status)

  # Farbcodes definieren
  local red='\033[0;31m'
  local yellow='\033[0;33m'
  local green='\033[0;32m'
  local white='\033[0m'

  if [[ ${status} == "Not installed!" ]]; then
    status="${red}${status}${white}"
  elif [[ ${status} == "Incomplete!" ]]; then
    status="${yellow}${status}${white}"
  elif [[ ${status} == "Not linked!" ]]; then
    ### "Not linked!" wird nur für Moonraker-obico benötigt
    status="${yellow}${status}${white}"
  else
    status="${green}${status}${white}"
  fi

  # Status mit Zeilenumbruch zurückgeben statt auszugeben
  cat <<EOL
$status

EOL
}

function get_docker_status() {
  if command -v docker &> /dev/null; then
    DOCKER_VERSION=$(docker --version | cut -d ' ' -f 3)
    echo "Installed, $DOCKER_VERSION"
  else
    echo "Not installed!"
  fi
}

function main_menu() {
  clear && print_header
  main_ui

  local action
  while true; do
    read -p "${cyan}####### Perform action:${white} " action
    case "${action}" in
      1) clear && print_header
        new_install_menu
        break;;
      2) clear && print_header
        container_install_menu
        break;;
      3) clear && print_header
        program_install_menu
        break;;
      4) clear && print_header
        repair_menu
        break;;
      5) clear && print_header
        update_options_menu
        break;;
      Q|q)
        echo -e "${red}###### Exiting! ######${reset}"; echo
        exit 0;;
      *)
        deny_action "main_ui";;
    esac
  done
  main_menu
}
