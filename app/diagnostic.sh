#!/usr/bin/env bash

show_help() {
    cat <<'EOF'
Diagnostic CLI

Usage:
  diagnostic system
  diagnostic network <host>
  diagnostic disk
  diagnostic help

Commands:
  system          Display Linux system information
  network <host>  Check whether a host is reachable
  disk            Display disk usage information
  help            Display help
EOF
}

case "${1:-}" in
    system)
        if [[ $# -ne 1 ]]; then
            echo "Error: system takes no arguments." >&2
            exit 2
        fi

        echo "=== System Information ==="
        uname -a || exit 1
        echo "Hostname: $(hostname)" || exit 1
        uptime || exit 1
        free -h || exit 1
        ;;

    network)
        if [[ $# -ne 2 || -z "$2" || "$2" == -* ]]; then
            echo "Error: network requires a host." >&2
            exit 2
        fi

        if ping -c 1 -W 3 "$2"; then
            echo "Success: $2 is reachable."
            exit 0
        else
            echo "Error: $2 is unreachable." >&2
            exit 1
        fi
        ;;

    disk)
        if [[ $# -ne 1 ]]; then
            echo "Error: disk takes no arguments." >&2
            exit 2
        fi

        df -h || exit 1
        ;;

    help)
        if [[ $# -ne 1 ]]; then
            echo "Error: help takes no arguments." >&2
            exit 2
        fi

        show_help
        ;;

    "")
        echo "Error: No command provided." >&2
        show_help >&2
        exit 2
        ;;

    *)
        echo "Error: Invalid command '$1'." >&2
        show_help >&2
        exit 2
        ;;
esac
