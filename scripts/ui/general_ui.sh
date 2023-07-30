#!/usr/bin/env bash
set -e

# Define colors
#red=$(tput setaf 1)
#green=$(tput setaf 2)
#yellow=$(tput setaf 3)
#blue=$(tput setaf 4)
#magenta=$(tput setaf 5)
#cyan=$(tput setaf 6)
#white=$(tput setaf 7)
#reset=$(tput sgr0)

set -e

#ui total width = 57 chars
function top_border() {
  echo -e "/=======================================================\\"
}

function bottom_border() {
  echo -e "\=======================================================/"
}

function blank_line() {
  echo -e "|                                                       |"
}

function hr() {
  echo -e "|-------------------------------------------------------|"
}

function quit_footer() {
  hr
  echo -e "|                        ${red}Q) Quit${white}                        |"
  bottom_border
}

function back_footer() {
  hr
  echo -e "|                       ${green}B) « Back${white}                       |"
  bottom_border
}
function back/close_footer() {
  hr
  echo -e "|         ${green}B) « Back${white}         |        ${red}Q) Quit${white}            |"
  bottom_border
}
function back_help_footer() {
  hr
  echo -e "|         ${green}B) « Back${white}         |        ${yellow}H) Help [?]${white}        |"
  bottom_border
}

function print_header() {
  top_border
  echo -e "|     $(title_msg "~~~~~~~~~~~~~ [ Goldjunge491 ] ~~~~~~~~~~~~~~")     |"
  echo -e "|     $(title_msg "  Pi-installer Installation And Update Helper   ")  |"
  echo -e "|     $(title_msg "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")     |"
  bottom_border
}
function do_action() {
  clear && print_header
  ### $1 is the action the user wants to fire
  $1
#  print_msg && clear_msg
  ### $2 is the menu the user usually gets directed back to after an action is completed
  $2
}

function deny_action() {
  clear && print_header
  print_error "Invalid command!"
  $1
}
