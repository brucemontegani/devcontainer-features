#!/usr/bin/env bash
set -e

echo "🔬 Running unit tests..."
for test in tests/unit/*.sh; do
    echo "▶️  $test"
    bash "$test"
done

echo ""
echo "🧪 Running integration tests..."
for test in tests/integration/*.sh; do
    echo "▶️  $test"
    bash "$test"
done

echo ""
echo "✅ All tests passed"

#!/usr/bin/env bash
set -e

# Run all tests under the framework tests directory
for test_file in $(find "$(dirname "$0")" -type f -name "test-*.sh"); do
    echo "Running $test_file..."
    bash "$test_file"
done

