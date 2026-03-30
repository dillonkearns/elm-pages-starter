#!/usr/bin/env bash
# sync-from-init.sh — Compare this starter repo against a fresh `elm-pages init`
#
# Scaffolds a fresh project from the latest (or specified) elm-pages version
# and diffs it against this repo. Helps keep the starter in sync with the
# init template.
#
# Usage:
#   ./sync-from-init.sh              # diff against latest published elm-pages
#   ./sync-from-init.sh --apply      # copy non-ignored files from init over this repo
#   ./sync-from-init.sh --version 3.3.0  # use a specific npm version

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VERSION="latest"
APPLY=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --apply) APPLY=1; shift ;;
    --version) VERSION="$2"; shift 2 ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

WORK_DIR=$(mktemp -d)
trap "rm -rf $WORK_DIR" EXIT

echo "Scaffolding fresh project with elm-pages@$VERSION..."
cd "$WORK_DIR"
npx "elm-pages@$VERSION" init fresh-project 2>&1 | tail -1

FRESH="$WORK_DIR/fresh-project"

# Files that only exist in this starter (intentional additions) or are
# generated/ephemeral — exclude from the diff
EXCLUDES=(
  --exclude=node_modules
  --exclude=elm-stuff
  --exclude=.elm-pages
  --exclude=dist
  --exclude=.git
  --exclude=.gitignore      # init template has "gitignore" which gets renamed
  --exclude=package-lock.json
  --exclude=.nvmrc
  --exclude=.npmrc
  --exclude=.idea
  --exclude=.claude-status.json
  --exclude=.session-icon
  --exclude=.scratch
  --exclude=gen
  --exclude=functions
  --exclude=codegen
  --exclude='*.mjs'         # generated script bundles
  --exclude=sync-from-init.sh
  --exclude=stars.mjs
)

echo ""
if [ "$APPLY" -eq 1 ]; then
  echo "=== Applying changes from fresh init ==="
  # Copy files from fresh scaffold, but don't delete starter-only files
  rsync -av --existing "$FRESH/" "$REPO_ROOT/" "${EXCLUDES[@]}" 2>/dev/null || true
  # Also copy any NEW files from the template (that don't exist in starter yet)
  rsync -av "$FRESH/" "$REPO_ROOT/" "${EXCLUDES[@]}" --ignore-existing 2>/dev/null | grep -v '/$' || true
  echo ""
  echo "Applied. Review changes with: git diff"
else
  echo "=== Diff: fresh init vs starter repo ==="
  echo "(use --apply to copy these changes over)"
  echo ""
  diff -ru "$FRESH" "$REPO_ROOT" "${EXCLUDES[@]}" || true
fi
