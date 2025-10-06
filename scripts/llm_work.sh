#!/bin/bash

set -euo pipefail

# Generate a feature branch name
generate_branch_name() {
  local timestamp=$(date +%Y%m%d-%H%M%S)
  local random_suffix=$(openssl rand -hex 4)
  echo "feature/llm-work-${timestamp}-${random_suffix}"
}

# Main function
main() {
  local branch_name

  if [[ $# -gt 0 ]]; then
    branch_name="feature/$1"
  else
    branch_name=$(generate_branch_name)
  fi

  echo "🚀 Creating feature branch: $branch_name"

  # Check if we're on main/develop
  current_branch=$(git branch --show-current)
  if [[ "$current_branch" == "main" || "$current_branch" == "develop" ]]; then
    echo "✅ Currently on $current_branch - safe to create branch"
  else
    echo "⚠️  Currently on $current_branch - make sure this is intended"
  fi

  # Create and switch to branch
  git checkout -b "$branch_name"

  echo "✅ Branch created and checked out"
  echo ""
  echo "Next steps:"
  echo "1. Make your changes"
  echo "2. Backup important files: ./scripts/backup_file.sh <file>"
  echo "3. Test your changes: pnpm test"
  echo "4. Commit: git add . && git commit -m 'description'"
  echo "5. Push: git push -u origin $branch_name"
  echo "6. Create PR when ready"
}

main "$@"