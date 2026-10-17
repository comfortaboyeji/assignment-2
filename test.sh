#!/usr/bin/env bash

set -u

IMAGE="diagnostic-tool"
passed=0
failed=0

echo "Building Docker image..."
if ! docker build -t "$IMAGE" .; then
    echo "FAIL: Docker image build failed."
    exit 1
fi

run_test() {
    local description="$1"
    local expected_exit="$2"
    shift 2

    local output
    local actual_exit

    output=$(docker run --rm "$IMAGE" "$@" 2>&1)
    actual_exit=$?

    if [[ "$actual_exit" -eq "$expected_exit" ]]; then
        echo "PASS: $description"
        ((passed += 1))
    else
        echo "FAIL: $description"
        echo "Expected exit code: $expected_exit"
        echo "Actual exit code: $actual_exit"
        echo "$output"
        ((failed += 1))
    fi
}

run_test "Help command" 0 help
run_test "System command" 0 system
run_test "Disk command" 0 disk
run_test "Invalid command" 2 invalid-command
run_test "Missing command" 2
run_test "Missing network host" 2 network
run_test "Extra system argument" 2 system extra
run_test "Extra disk argument" 2 disk extra

echo
echo "========== TEST SUMMARY =========="
echo "Passed: $passed"
echo "Failed: $failed"

if [[ "$failed" -gt 0 ]]; then
    exit 1
fi

echo "All tests passed."
exit 0
