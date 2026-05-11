#!/bin/bash

set -e

# Settings
COVERAGE_FILE="coverage/lcov.info"
COMPARE_BRANCH=${1:-"main"} # default to 'main' if not passed
THRESHOLD=${2:-80}          # default threshold 80%
IS_LOCAL=${3:-false}
LOG_FILE=${4:-"percentage_check.log"}  # default log file name



# Ensure required tools
command -v git >/dev/null 2>&1 || { echo >&2 "git is required."; exit 1; }
command -v lcov >/dev/null 2>&1 || { echo >&2 "lcov is required."; exit 1; }
command -v python3 >/dev/null 2>&1 || { echo >&2 "python3 is required."; exit 1; }
if [ "$IS_LOCAL" = true ]; then
  command -v pipx >/dev/null 2>&1 || { echo >&2 "pipx is required."; exit 1; }
else 
  command -v pip >/dev/null 2>&1 || { echo >&2 "pip is required."; exit 1; }
fi

# Setup and activate virtualenv
if [ ! -d ".venv" ]; then
  echo "🔧 Creating virtual environment..."
  python3 -m venv .venv
fi


./scripts/ci/coverage_check.sh --no-open


source .venv/bin/activate
if [ "$IS_LOCAL" = true ]; then
  pipx install diff-cover
else
  pip install diff-cover
fi



# Install diff-cover if not already
if ! command -v diff-cover &>/dev/null; then
  echo "📦 Installing diff-cover..."
  if [ "$IS_LOCAL" = true ]; then
    pipx install diff-cover
  else
    pip install diff-cover
  fi
fi

# Ensure coverage file exists
if [ ! -f "$COVERAGE_FILE" ]; then
  echo "❌ Coverage file not found at $COVERAGE_FILE"
  exit 1
fi

echo "✅ Using coverage file: $COVERAGE_FILE"
echo "🔍 Comparing against branch: $COMPARE_BRANCH"
echo "🎯 Threshold: $THRESHOLD%"


if [ "$IS_LOCAL" = false ]; then
  echo "🔍 Fetching origin/$COMPARE_BRANCH"
  git fetch --all --prune
  git fetch
  git fetch origin "$COMPARE_BRANCH"
fi

if [ "$IS_LOCAL" = false ]; then
  # Optional safety check
  if ! git merge-base --is-ancestor "origin/$COMPARE_BRANCH" HEAD; then
    echo "❌ No merge base found between HEAD and origin/$COMPARE_BRANCH"
    exit 1
  fi
else 
# Optional safety check
if ! git merge-base --is-ancestor "$COMPARE_BRANCH" HEAD; then
  echo "❌ No merge base found between HEAD and $COMPARE_BRANCH"
  exit 1
fi
  
fi    

if [ "$IS_LOCAL" = false ]; then
  # Run the diff-cover check
  diff-cover "$COVERAGE_FILE" \
    --compare-branch "origin/$COMPARE_BRANCH" \
    --fail-under "$THRESHOLD"
else 
  # Run the diff-cover check
  pipx run diff-cover "$COVERAGE_FILE" \
    --compare-branch "$COMPARE_BRANCH" \
    --fail-under "$THRESHOLD" | tee -a "$LOG_FILE"
fi    

echo "✅ Diff coverage report saved to $LOG_FILE"

