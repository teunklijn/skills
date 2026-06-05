#!/usr/bin/env bash
#
# install.sh — install the skills in this repo into an agent's skills directory.
#
# By default it symlinks every skill under ./skills into ~/.claude/skills, so the
# skills stay in sync with this repo (a `git pull` updates them everywhere).
#
# Usage:
#   ./scripts/install.sh                 # symlink into ~/.claude/skills
#   ./scripts/install.sh --copy          # copy instead of symlink
#   ./scripts/install.sh --target DIR    # install into DIR instead of ~/.claude/skills
#   ./scripts/install.sh --list          # list available skills and exit
#   SKILLS_TARGET=/path ./scripts/install.sh   # same as --target via env var
#
set -euo pipefail

# Resolve the repo root from this script's location (works regardless of cwd).
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SKILLS_SRC="$REPO_ROOT/skills"

TARGET="${SKILLS_TARGET:-$HOME/.claude/skills}"
MODE="symlink"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --copy)    MODE="copy"; shift ;;
    --target)  TARGET="$2"; shift 2 ;;
    --list)    MODE="list"; shift ;;
    -h|--help)
      grep '^#' "$0" | sed 's/^# \{0,1\}//'
      exit 0 ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
done

if [[ ! -d "$SKILLS_SRC" ]]; then
  echo "No skills/ directory found at $SKILLS_SRC" >&2
  exit 1
fi

# Collect skill directories (those containing a SKILL.md).
SKILLS=()
for dir in "$SKILLS_SRC"/*/; do
  [[ -f "$dir/SKILL.md" ]] && SKILLS+=("$(basename "$dir")")
done

if [[ ${#SKILLS[@]} -eq 0 ]]; then
  echo "No skills found under $SKILLS_SRC" >&2
  exit 1
fi

if [[ "$MODE" == "list" ]]; then
  echo "Available skills:"
  for s in "${SKILLS[@]}"; do echo "  - $s"; done
  exit 0
fi

mkdir -p "$TARGET"
echo "Installing ${#SKILLS[@]} skill(s) into $TARGET ($MODE)"

for s in "${SKILLS[@]}"; do
  src="$SKILLS_SRC/$s"
  dest="$TARGET/$s"
  if [[ -e "$dest" || -L "$dest" ]]; then
    rm -rf "$dest"
  fi
  if [[ "$MODE" == "copy" ]]; then
    cp -R "$src" "$dest"
  else
    ln -s "$src" "$dest"
  fi
  echo "  ✓ $s"
done

echo "Done. Restart your agent or reload skills to pick them up."
