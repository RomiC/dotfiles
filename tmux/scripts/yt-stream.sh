#!/usr/bin/env bash
set -uo pipefail

pause() {
  read -r -p "Press Enter to close." _ || true
}

fail() {
  printf '%s\n' "$1" >&2
  pause
  exit 1
}

for tool in yt-dlp jq fzf op curl; do
  command -v "$tool" >/dev/null 2>&1 || fail "Missing command: $tool"
done

printf 'Loading live streams from Lofi Girl...\n'
streams=$(yt-dlp --flat-playlist --dump-json "https://www.youtube.com/@LofiGirl/streams" |
  jq -r 'select(.live_status == "is_live") | "\(.id) \(.title)"') ||
  fail "Could not load live streams."
[[ -n "$streams" ]] || fail "No live streams found."

selection=$(printf '%s\n' "$streams" |
  fzf --layout reverse --with-nth 2.. --prompt 'Live stream > ')
selection_status=$?
case "$selection_status" in
  0) ;;
  1|130) exit 0 ;;
  *) fail "The stream selector failed."
esac

video_id=${selection%% *}
[[ "$video_id" =~ ^[A-Za-z0-9_-]{11}$ ]] || fail "Invalid YouTube video ID."

printf 'Selected: %s\n' "${selection#* }"
token=$(op item get --vault "Personal" "yt-stream - local" --fields label=credential --reveal) ||
  fail "Could not read the API token from 1Password."
[[ -n "$token" ]] || fail "The API token is empty."

printf 'Starting stream...\n'
# Read the authorization header from stdin to keep the token out of process arguments.
http_status=$(curl --header @- --get --data-urlencode "url=https://youtu.be/$video_id" \
  --max-time 60 --output /dev/null --silent --show-error --write-out '%{http_code}' \
  "https://yts.charugin.me:4443/api/stream" <<< "Authorization: Bearer $token") ||
  fail "The stream API request failed."
unset token

case "$http_status" in
  302) printf 'Stream started! Closing window in 3s'; sleep 3; exit 0 ;;
  *) fail "The stream API returned HTTP $http_status. Expected HTTP 302." ;;
esac
