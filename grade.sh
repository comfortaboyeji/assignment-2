#!/usr/bin/env bash

set -u

echo "Starting grading checks..."

if ! command -v docker >/dev/null 2>&1; then
    echo "ERROR: Docker is not installed or not in PATH."
    exit 1
fi

if ! docker info >/dev/null 2>&1; then
    echo "ERROR: Docker is not running or is inaccessible."
    exit 1
fi

for file in README.md Dockerfile compose.yaml \
            .dockerignore test.sh \
            app/diagnostic.sh app/health-check.sh; do
    if [[ ! -f "$file" ]]; then
        echo "ERROR: Missing required file: $file"
        exit 1
    fi
done

if bash test.sh; then
    echo "GRADING RESULT: All automated tests passed."
    exit 0
else
    echo "GRADING RESULT: Tests failed."
    exit 1
fi




