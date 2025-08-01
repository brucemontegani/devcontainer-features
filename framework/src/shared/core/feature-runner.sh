#!/usr/bin/env bash
set -e

FEATURE_DIR="$1"

if [ -z "$FEATURE_DIR" ]; then
    echo "❌ ERROR: Missing feature directory path." >&2
    exit 1
fi

# Load core logic
source "$(dirname "$0")/feature-utils.sh"
source "$(dirname "$0")/feature-core.sh"
source "$(dirname "$0")/../validations/shared-validations.sh"
source "$(dirname "$0")/../validations/group-validations.sh"

# Load lifecycle hooks from the feature itself
hooks_file="$FEATURE_DIR/feature-hooks.sh"
if [ -f "$hooks_file" ]; then
    log_info --dim "Sourcing lifecycle hooks: $(basename "$hooks_file")"
    source "$hooks_file"
else
    for hook in validate install teardown; do
        local_hook_file="$FEATURE_DIR/feature-${hook}.sh"
        if [ -f "$local_hook_file" ]; then
            log_info --dim "Sourcing: $(basename "$local_hook_file")"
            source "$local_hook_file"
        fi
    done
fi

# Run the lifecycle with the provided feature directory
run_feature_lifecycle "$FEATURE_DIR"
