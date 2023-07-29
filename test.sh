#!/usr/bin/env bash
PFAD="$(dirname -- "$(readlink -f "${BASH_SOURCE[0]}")")"
for script in "${PFAD}/scripts/"*.sh; do . "${script}"; done
for script in "${PFAD}/scripts/ui/"*.sh; do . "${script}"; done

echo "Der Wert der Variable PFAD ist: $PFAD"