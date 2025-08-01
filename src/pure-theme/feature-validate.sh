feature_validate() {
  require_path "$_REMOTE_USER_HOME/.zshrc" "Expected .zshrc to exist."
  require_file_contains "$_REMOTE_USER_HOME/.zshrc" "ZSH_THEME=" "Missing ZSH_THEME config."
}
