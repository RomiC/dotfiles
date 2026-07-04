#!/usr/bin/env bash
# Create archive from selected files, preserving relative paths from CWD
# Usage: create-archive.sh <zip|tar> <archive-name> <file1> [file2...]

set -euo pipefail

if [ $# -lt 3 ]; then
  echo "Usage: $0 <zip|tar> <archive-name> <file1> [file2...]"
  exit 1
fi

format="$1"
archive_name="$2"
shift 2

# Strip known archive extensions if user provided them
archive_name="${archive_name%.zip}"
archive_name="${archive_name%.tar.gz}"
archive_name="${archive_name%.tgz}"
archive_name="${archive_name%.tar}"

cwd="$(pwd)"

# Convert absolute paths to relative from CWD
rel_files=()
for f in "$@"; do
  rel_files+=("${f#$cwd/}")
done

case "$format" in
  zip)
    cd "$cwd" && zip -r "${archive_name}.zip" "${rel_files[@]}"
    echo "${archive_name}.zip"
    ;;
  tar)
    cd "$cwd" && tar -czf "${archive_name}.tar.gz" "${rel_files[@]}"
    echo "${archive_name}.tar.gz"
    ;;
esac
