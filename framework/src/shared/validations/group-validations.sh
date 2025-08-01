#!/usr/bin/env bash
set -e

group_validate_zsh_plugins() {
    log_info "Validating zsh_plugins group..."

    require_command "zsh" "Install 'common-utils'"
    require_path "$_REMOTE_USER_HOME/.oh-my-zsh" "Oh My Zsh must be installed. Install common-utils"
}
