#!/usr/bin/env bash
# Open lazygit in a tmux popup, then signal Yazi to resume.
SIGNAL="yazi-lazygit-$$"
tmux display-popup \
    -E \
    -w 80% \
    -h 80% \
    -d "$PWD" \
    "lazygit; tmux wait-for -S ${SIGNAL}"
tmux wait-for "${SIGNAL}"
