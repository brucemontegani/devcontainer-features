# #!/usr/bin/env bash
# set -e

# BASE_DIR="$(dirname "$0")"

# FEATURE_ID="pure-theme"

# # Load shared lifecycle core and utilities
# source "$BASE_DIR/feature-hooks.sh"
# source "$BASE_DIR/../../shared/scripts/feature-utils.sh"
# source "$BASE_DIR/../../shared/scripts/feature-core.sh"

# # Run lifecycle
# run_feature_lifecycle

#!/usr/bin/env bash
set -e

FEATURE_DIR="$(dirname "$0")"
CORE_RUNNER="$FEATURE_DIR/../../shared/core/feature-runner.sh"

exec "$CORE_RUNNER" "$FEATURE_DIR"



