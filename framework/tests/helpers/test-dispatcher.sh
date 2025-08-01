#!/usr/bin/env bash
set -e

# Generic test dispatcher for use in unit/integration test files

if [[ "$1" == "--list" ]]; then
    echo "Available tests:"
    declare -F | awk '{print "  - "$3}' | grep '^  - test_'
    exit 0
elif [[ -n "$1" ]]; then
    if declare -f "$1" > /dev/null; then
        echo "▶️  Running test: $1"
        "$1"
    else
        echo "❌ Unknown test: $1"
        echo "Available tests:"
        declare -F | awk '{print "  - "$3}' | grep '^  - test_'
        exit 1
    fi
else
    echo "ℹ️  No specific test provided. Running all tests..."
    for test_func in $(declare -F | awk '{print $3}' | grep '^test_'); do
        echo "▶️  $test_func"
        "$test_func"
        echo ""
    done
fi
