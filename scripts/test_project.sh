#!/bin/bash

set -euo pipefail

# Configuration
STRICT_MODE=${STRICT_MODE:-1}
PARALLEL_TESTS=${PARALLEL_TESTS:-4}
VERBOSE=${VERBOSE:-0}

# Test categories
declare -A test_results=(
  [syntax]=0
  [linting]=0
  [naming]=0
  [security]=0
  [formatting]=0
)

# Syntax validation with language detection
test_syntax() {
  local file="$1"
  case "$file" in
    *.zsh|*.sh)
      if command -v zsh &>/dev/null; then
        zsh -n "$file" || return 1
      else
        bash -n "$file" || return 1
      fi
      ;;
    *.py)
      if command -v python &>/dev/null; then
        python -m py_compile "$file" || return 1
      fi
      ;;
    *.js|*.ts)
      if command -v node &>/dev/null; then
        node --check "$file" 2>/dev/null || return 1
      fi
      ;;
    *.json)
      if command -v jq &>/dev/null; then
        jq empty "$file" >/dev/null || return 1
      fi
      ;;
    *.yaml|*.yml)
      if command -v yamllint &>/dev/null; then
        yamllint "$file" >/dev/null || return 1
      else
        echo "yamllint not available, skipping YAML validation for $file"
      fi
      ;;
  esac
}

# Security checks
test_security() {
  # Check for hardcoded secrets
  if git diff --cached | grep -iE '(password|api_key|secret|token)\s*=\s*["\047][^"\047]+["\047]'; then
    echo "❌ Possible hardcoded credentials detected"
    return 1
  fi
}

# Naming convention enforcement
test_naming() {
  local forbidden_words="improved|enhanced|ultimate|final|new|old|temp|backup"
  if echo "$1" | grep -qiE "$forbidden_words"; then
    echo "❌ Forbidden naming in: $1"
    return 1
  fi
}

# Run all tests with parallel execution
run_tests() {
  local files=("$@")
  export -f test_syntax test_security test_naming

  printf '%s\n' "${files[@]}" | xargs -P "$PARALLEL_TESTS" -I {} bash -c '
    if test_syntax "{}"; then
      echo "✅ Syntax OK: {}"
    else
      echo "❌ Syntax FAIL: {}"
      exit 1
    fi
  ' || return 1

  printf '%s\n' "${files[@]}" | xargs -P "$PARALLEL_TESTS" -I {} bash -c '
    if test_security "{}"; then
      echo "✅ Security OK: {}"
    else
      echo "❌ Security FAIL: {}"
      exit 1
    fi
  ' || return 1

  printf '%s\n' "${files[@]}" | xargs -P "$PARALLEL_TESTS" -I {} bash -c '
    if test_naming "{}"; then
      echo "✅ Naming OK: {}"
    else
      echo "❌ Naming FAIL: {}"
      exit 1
    fi
  ' || return 1
}

# Report generation
generate_report() {
  local total=0 failed=0

  for category in "${!test_results[@]}"; do
    total=$((total + test_results[$category]))
    if [[ ${test_results[$category]} -gt 0 ]]; then
      failed=$((failed + test_results[$category]))
      echo "❌ $category: ${test_results[$category]} errors"
    fi
  done

  if [[ $failed -gt 0 ]]; then
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "❌ $failed/$total checks failed"
    return 1
  fi

  echo "✅ All $total checks passed"
}

# Main execution
main() {
  echo "🔍 Running validation suite..."

  # Find relevant files
  mapfile -t files < <(git diff --cached --name-only --diff-filter=ACM)

  if [[ ${#files[@]} -eq 0 ]]; then
    echo "No files to validate"
    exit 0
  fi

  run_tests "${files[@]}"
  generate_report
}

main "$@"