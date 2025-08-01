#!/usr/bin/env bash
set -e

FEATURE_NAME="${FEATURE_NAME:-$(basename $(dirname $(dirname "$BASH_SOURCE")))}"
PREFIX="[${FEATURE_NAME}]"

style() {
  local text="$1"; shift
  local esc=""
  local RESET="\033[0m"
  for arg in "$@"; do
    case "$arg" in
      black) esc+="\033[0;30m";; red) esc+="\033[0;31m";; green) esc+="\033[0;32m";;
      yellow) esc+="\033[0;33m";; blue) esc+="\033[0;34m";; magenta) esc+="\033[0;35m";;
      cyan) esc+="\033[0;36m";; white) esc+="\033[0;37m";;
      bright_red) esc+="\033[0;91m";; bright_green) esc+="\033[0;92m";;
      bright_yellow) esc+="\033[0;93m";; bright_blue) esc+="\033[0;94m";;
      bold) esc+="\033[1m";; underline) esc+="\033[4m";;
      *) echo "Unknown style: $arg" >&2;;
    esac
  done
  echo -e "${esc}${text}${RESET}"
}

log_info() { echo -e "🔧 $(style "$PREFIX $*" green)"; }
log_warn() { echo -e "⚠️  $(style "$PREFIX $*" yellow)"; }
log_error() { echo -e "❌ $(style "$PREFIX $*" red bold)" >&2; }

require_env_var() {
  [ -z "${!1}" ] && log_error "Missing env var: $1" && [ -n "$2" ] && echo -e "$(style "💡 $2" bright_yellow)" && exit 1
}

require_command() {
  ! command -v "$1" &>/dev/null && log_error "Missing command: $1" && [ -n "$2" ] && echo -e "$(style "💡 $2" bright_yellow)" && exit 1
}

require_path() {
  [ ! -e "$1" ] && log_error "Missing path: $1" && [ -n "$2" ] && echo -e "$(style "💡 $2" bright_yellow)" && exit 1
}

require_file_contains() {
  grep -qE "$2" "$1" || { log_error "File '$1' does not contain: $2"; [ -n "$3" ] && echo -e "$(style "💡 $3" bright_yellow)"; exit 1; }
}
