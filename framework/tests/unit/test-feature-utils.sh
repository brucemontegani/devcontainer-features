#!/usr/bin/env bash
set -e
source ./shared/core/feature-utils.sh

echo "Test: style() output (visually inspect)"
assert_eq "$(style 'Test' green)" $'\033[0;32mTest\033[0m' "style should return green text"
# style "Hello" green bold

echo "Test: require_env_var (should fail)"
export FOO=""
if require_env_var "FOO" "FOO is required"; then
    echo "❌ FAIL: require_env_var should have exited"
    exit 1
else
    echo "✅ require_env_var correctly exited"
fi
