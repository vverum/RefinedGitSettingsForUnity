#!/usr/bin/env bash

# Usage: ./setup-unity-merge.sh "/full/path/to/UnityYAMLMerge"

MERGETOOL_PATH="$1"

if [ -z "$MERGETOOL_PATH" ]; then
  echo "Error: Provide path to UnityYAMLMerge"
  echo "Usage: $0 \"/full/path/to/UnityYAMLMerge\""
  exit 1
fi

# Ensure we're inside a git repo
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  echo "Error: Not inside a git repository"
  exit 1
fi

# Set merge tool (local config)
git config merge.tool unityyamlmerge
git config mergetool.unityyamlmerge.trustExitCode false

git config mergetool.unityyamlmerge.cmd \
"\"$MERGETOOL_PATH\" merge -p \"\$BASE\" \"\$REMOTE\" \"\$LOCAL\" \"\$MERGED\""

echo "UnityYAMLMerge configured for this repository."
