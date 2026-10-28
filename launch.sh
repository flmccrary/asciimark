#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
mode="${1:-edit}"
case "$mode" in
  edit) entry_name=asciiEdit.html ;;
  view|--view) entry_name=asciiView.html ;;
  *) printf 'Usage: %s [edit|view]\n' "$0" >&2; exit 2 ;;
esac
entry_path="$repo_root/$entry_name"

if [[ ! -f "$entry_path" ]]; then
  bash "$repo_root/build.sh"
fi
if [[ ! -f "$entry_path" ]]; then
  printf 'AsciiDoc entry point not found: %s\n' "$entry_path" >&2
  exit 1
fi

if command -v wslview >/dev/null 2>&1; then
  wslview "$entry_path"
elif command -v xdg-open >/dev/null 2>&1; then
  xdg-open "$entry_path"
elif command -v cmd.exe >/dev/null 2>&1 && command -v wslpath >/dev/null 2>&1; then
  windows_path="$(wslpath -w "$entry_path")"
  cmd.exe /c start "" "$windows_path"
else
  printf 'No file opener found. Open this file in a browser: %s\n' "$entry_path" >&2
  exit 1
fi
