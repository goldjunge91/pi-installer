#!/usr/bin/env bash
set -e

function install_ui() {
  top_border
  echo -e "|     ${green}~~~~~~~~~~~ [ Installation Menu ] ~~~~~~~~~~~${white}     |"
  hr
  echo -e "|  You need this menu usually only for installing       |"
  echo -e "|  all necessary dependencies for the various           |"
  echo -e "|  functions on a completely fresh system.              |"
  hr
  echo -e "| Docker:                  | Touchscreen GUI:           |"
  echo -e "|  1) Docker               |  6) []                     |"
  echo -e "|  2) Container            |                            |"
  echo -e "|                          | Other:                     |"
  echo -e "| Text                     |  7) []                     |"
  echo -e "|  3) [???]                |  8) []                     |"
  echo -e "|  4) []                   |  9) []                     |"
  echo -e "|                          | 10) []                     |"
  echo -e "|                          | 11) []                     |"
  echo -e "| Gruppenname:             |                            |"
  echo -e "|  5) []                   | Gruppenname:               |"
  echo -e "|                          | 12) [Crowsnest]            |"
  back_footer
}
####   echo -e "|  4) []                   |  9) $(obico_install_title) |"

function install_menu() {
  clear -x && sudo -v && clear -x # (re)cache sudo credentials so password prompt doesn't bork ui
  print_header
  install_ui
  local action
  while true; do
    read -p "${cyan}####### Perform action:${white} " action
    case "${action}" in
      1)
        do_action "start_docker_setup" "install_ui";;
      2)
        do_action "container_install" "install_ui";;
      3)
        do_action "install_mainsail" "install_ui";;
      4)
        do_action "install_fluidd" "install_ui";;
      5)
        do_action "install_klipperscreen" "install_ui";;
      6)
        do_action "octoprint_setup_dialog" "install_ui";;
      7)
        do_action "install_pgc_for_klipper" "install_ui";;
      8)
        do_action "telegram_bot_setup_dialog" "install_ui";;
      9)
        do_action "moonraker_obico_setup_dialog" "install_ui";;
      10)
        do_action "octoeverywhere_setup_dialog" "install_ui";;
      11)
        do_action "install_mobileraker" "install_ui";;
      12)
        do_action "install_crowsnest" "install_ui";;
      B|b)
        clear; main_menu; break;;
      *)
        deny_action "install_ui";;
    esac
  done
  install_menu
}
