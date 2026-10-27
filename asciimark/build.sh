#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
template_path="$repo_root/src/asciiApp.template.html"

if [[ ! -f "$template_path" ]]; then
  printf 'Shared app template not found: %s\n' "$template_path" >&2
  exit 1
fi

python3 - "$template_path" "$repo_root" <<'PY'
from pathlib import Path
import sys

template_path, repo_root = map(Path, sys.argv[1:])
template = template_path.read_text(encoding="utf-8")
marker = "const mode='__APP_MODE__';"
if marker not in template:
    raise SystemExit("The shared template is missing the app mode marker.")

for mode, output_name in (("view", "asciiView.html"), ("edit", "asciiEdit.html")):
    with (repo_root / output_name).open("w", encoding="utf-8", newline="\n") as output:
        output.write(template.replace(marker, f"const mode='{mode}';"))
print("Built asciiView.html and asciiEdit.html from the shared template.")
PY
