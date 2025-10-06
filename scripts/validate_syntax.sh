#!/bin/bash

set -euo pipefail

# Syntax validation with language detection
validate_file() {
  local file="$1"
  case "$file" in
    *.zsh|*.sh)
      if command -v zsh &>/dev/null; then
        zsh -n "$file"
      else
        bash -n "$file"
      fi
      ;;
    *.py)
      if command -v python &>/dev/null; then
        python -m py_compile "$file"
      fi
      ;;
    *.js|*.ts)
      if command -v node &>/dev/null; then
        node --check "$file" 2>/dev/null || echo "Syntax check failed for $file"
      fi
      ;;
    *.json)
      if command -v jq &>/dev/null; then
        jq empty "$file" >/dev/null
      fi
      ;;
    *.yaml|*.yml)
      if command -v yamllint &>/dev/null; then
        yamllint "$file" >/dev/null
      else
        echo "yamllint not available, skipping YAML validation for $file"
      fi
      ;;
    *)
      echo "No syntax validation available for $file"
      ;;
  esac
}

# Process all files passed as arguments
for file in "$@"; do
  if [[ -f "$file" ]]; then
    validate_file "$file"
  fi
done