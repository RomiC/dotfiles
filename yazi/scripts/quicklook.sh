#!/usr/bin/env bash
# macOS Quick Look (Finder-style Space preview) for yazi: quicklook.sh <file>...

[[ "$(uname -s)" == "Darwin" ]] || exit 0
(($#)) || exit 0

# Replace any open preview so windows don't pile up.
pkill -x qlmanage 2>/dev/null

qlmanage -p "$@" >/dev/null 2>&1 &
ql_pid=$!

# qlmanage opens behind the focused app; raise it once the panel is mapped.
sleep 0.3
osascript -e 'tell application "System Events" to set frontmost of process "qlmanage" to true' >/dev/null 2>&1

wait "$ql_pid" 2>/dev/null
