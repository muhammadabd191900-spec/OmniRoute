#!/bin/bash
# SessionStart hook: install the repo-bundled research skills into ~/.claude/skills
# so Claude Code loads them automatically in every cloud session.
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

cd "${CLAUDE_PROJECT_DIR:-.}"

dest="${HOME}/.claude/skills"
mkdir -p "$dest"

for name in paper-lookup pkpd-modeling scientific-critical-thinking; do
  src="skills/$name"
  [ -f "$src/SKILL.md" ] || continue
  rm -rf "${dest:?}/$name"
  cp -r "$src" "$dest/$name"
done
