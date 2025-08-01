#!/usr/bin/env bash
# Shared test assertion helpers for unit tests

assert_eq() {
    local expected="$1"
    local actual="$2"
    local msg="${3:-}"  # optional

    if [ "$expected" = "$actual" ]; then
        echo "✅ PASS: $msg"
    else
        echo "❌ FAIL: $msg"
        echo "   Expected: '$expected'"
        echo "   Actual:   '$actual'"
        exit 1
    fi
}

assert_exit_code() {
    local expected_code="$1"
    shift

    "$@"
    local actual_code=$?

    if [ "$actual_code" -eq "$expected_code" ]; then
        echo "✅ PASS: '$*' exited with $expected_code"
    else
        echo "❌ FAIL: '$*' exited with $actual_code (expected $expected_code)"
        exit 1
    fi
}

assert_file_contains() {
    local file="$1"
    local pattern="$2"

    if grep -qE "$pattern" "$file"; then
        echo "✅ PASS: '$file' contains pattern '$pattern'"
    else
        echo "❌ FAIL: '$file' missing pattern '$pattern'"
        exit 1
    fi
}
