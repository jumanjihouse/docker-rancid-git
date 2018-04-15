# shellcheck shell=bash

################################################################################
# This collection of helper functions is sourced by the ci scripts.
################################################################################

finish() {
  declare -ri RC=$?

  if [[ ${RC} -eq 0 ]]; then
    echo "[INFO] $0 OK"
  else
    echo "[ERROR] $0 failed with exit code ${RC}"
  fi
}

trap finish EXIT
