#!/usr/bin/env bash
set -e
packages=("apt-transport-https" "ntfs-3g" "ca-certificates" "curl" "gnupg2" "software-properties-common" "docker-ce" "docker-ce-cli" "containerd.io" "docker-compose")

function check_packages() {
    local flag=0
    for package in "${packages[@]}"; do
        dpkg -s $package &> /dev/null
        if [ $? -eq 0 ]; then
            echo "Das Paket '$package' ist bereits installiert."
        else
            echo "Das Paket '$package' ist nicht installiert."
            flag=1
        fi
    done
    program_ui
    if [ $flag -eq 0 ]; then
        echo "Alle Pakete sind installiert."
    else
        echo "Einige Pakete sind nicht installiert."
    fi
    program_ui  # kehrt zur Benutzeroberfläche zurück
}

function install_packages() {
    local flag=0
    for package in "${packages[@]}"; do
        if ! dpkg -s $package &> /dev/null; then
            echo "Installiere Paket '$package'..."
            if sudo apt-get install -y $package; then
                echo "Das Paket '$package' wurde erfolgreich installiert."
            else
                echo "Fehler bei der Installation des Pakets '$package'."
                flag=1
            fi
        fi
    done
    if [ $flag -eq 0 ]; then
        echo "Alle Pakete wurden erfolgreich installiert."
    else
        echo "Es gab Fehler bei der Installation einiger Pakete."
    fi
    program_ui  # kehrt zur Benutzeroberfläche zurück
}
function program_ui() {
    top_border
    echo -e "|     $(title_msg "~~~~~~~~~~~~~~~ [ programm Menu ] ~~~~~~~~~~~~~~~")     |"
    hr
    echo -e "| 1) Check Packages    |      |"
    echo -e "|                      |                                |"
    echo -e "| 2) Install Packages  |                                |"
    echo -e "|                      |                                |"
    echo -e "| 3)    |                                |"
    echo -e "|                      |                                |"
    echo -e "| 4)             |                                |"
    echo -e "|                      |                                |"
    echo -e "| 5)     |                                |"
    echo -e "|                      |                                |"
    echo -e "| 6)           |                                |"
    hr
    blank_line
    quit_footer
}
function program_menu() {
    while true; do
        clear && print_header
        program_ui || return 1 # Wenn keine Docker-Compose-Dateien gefunden wurden, gehe zurück zum Hauptmenü
    local action
    while true; do
        read -p "${cyan}####### Perform action:${white} " action
        case "${action}" in
            1)
            do_action "check_packages" "program_ui";;
            2)
            do_action "install_packages" "program_ui";;
            3)
            do_action "check_packages" "program_ui";;
            4)
            do_action "install_packages" "program_ui";;
            5)
            do_action "install_klipperscreen" "program_ui";;
            6)
            do_action "octoprint_setup_dialog" "program_ui";;
            7)
            do_action "install_pgc_for_klipper" "program_ui";;
            8)
            do_action "telegram_bot_setup_dialog" "program_ui";;
            9)
            do_action "moonraker_obico_setup_dialog" "program_ui";;
            10)
            do_action "octoeverywhere_setup_dialog" "program_ui";;
            11)
            do_action "install_mobileraker" "program_ui";;
            12)
            do_action "install_crowsnest" "program_ui";;
            B|b)
            clear; main_menu; break;;
            *)
            deny_action "program_ui";;
        esac
    done
    program_menu
}