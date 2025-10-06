#!/bin/bash

set -euo pipefail

echo "🔒 Setting up project safety features..."

# Check if pre-commit is installed
if ! command -v pre-commit &>/dev/null; then
    echo "Installing pre-commit..."
    pip install pre-commit
fi

# Install pre-commit hooks
echo "Installing pre-commit hooks..."
pre-commit install --install-hooks
pre-commit install --hook-type pre-push

# Create archive directory
echo "Creating backup archive directory..."
mkdir -p archive

# Test the setup
echo "Testing setup..."
pre-commit run --all-files --verbose || echo "Some checks failed - review and fix issues"

echo "✅ Safety setup complete!"
echo ""
echo "Next steps:"
echo "1. Create a feature branch: git checkout -b feature/your-feature"
echo "2. Before editing files: ./scripts/backup_file.sh <file>"
echo "3. Make your changes and commit normally"
echo "4. Run tests: pnpm test"
echo ""
echo "For help: man manual (if available) or check scripts/README.md"