 that the diagnostic application exists and is executable.
if [[ ! -x /usr/local/bin/diagnostic ]]; then
    echo "Health check failed: diagnostic CLI is missing or not executable." >&2
    exit 1
fi

# Verify that required commands are installed.
for cmd in bash ping df free uptime hostname uname; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Health check failed: missing command: $cmd" >&2
        exit 1
    fi
done

echo "Health check passed."
exit 0


