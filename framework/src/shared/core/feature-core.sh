#!/usr/bin/env bash
set -e

source "$(dirname "$0")/feature-utils.sh"
source "$(dirname "$0")/../validations/shared-validations.sh"
source "$(dirname "$0")/../validations/group-validations.sh"

run_if_defined() {
  local hook="$1"
  if declare -f "$hook" > /dev/null; then
      log_info --dim "Running hook: $hook"
      "$hook"
  else
      log_warn "Hook '$hook' not defined. Skipping."
  fi
}

auto_source_lifecycle_scripts() {
  local feature_dir="${1:-.}"
  local hooks_file="$feature_dir/feature-hooks.sh"

  # Prefer single hook file if it exists
  if [ -f "$hooks_file" ]; then
      log_info --dim "Sourcing lifecycle hooks: $(basename "$hooks_file")"
      source "$hooks_file"
      return
  fi

  # Fallback to individual files
  for hook in validate install teardown; do
      local file="$feature_dir/feature-${hook}.sh"
      if [ -f "$file" ]; then
          log_info --dim "Sourcing: $(basename "$file")"
          source "$file"
      fi
  done
}

run_feature_lifecycle() {
  local feature_dir="${1:-.}"

  auto_source_lifecycle_scripts "$feature_dir"

  run_if_defined core_validate

  for group in "${FEATURE_GROUPS[@]}"; do
      run_if_defined "group_validate_${group}"
  done

  run_if_defined feature_validate
  run_if_defined feature_install
  run_if_defined feature_teardown
}
