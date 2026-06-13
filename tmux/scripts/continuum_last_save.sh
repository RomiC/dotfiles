#!/usr/bin/env bash

last_save=$(tmux show-option -gqv "@continuum-save-last-timestamp")

if [ -n "$last_save" ] && [ "$last_save" -gt 0 ] 2>/dev/null; then
  formatted=$(date -r "$last_save" "+Last save: %Y-%m-%d %H:%M:%S")
  echo "$formatted"
else
  echo "No save recorded yet"
fi
