FEATURE_GROUPS=("zsh_plugins")

feature_validate() {
    require_path "$_REMOTE_USER_HOME/.zshrc"
    require_file_contains "$_REMOTE_USER_HOME/.zshrc" "ZSH_THEME=" "Theme not configured"
}

feature_install() {
    # Your logic here
}



