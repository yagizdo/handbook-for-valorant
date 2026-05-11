#!/bin/bash
set -e
cd "$(dirname "$0")/../.." || exit 1

echo "Checking dart format (line-length=120)..."

# Collect non-generated .dart files (exclude *.g.dart, *.freezed.dart, *.gen.dart, *.gr.dart)
files=$(find lib modules -name '*.dart' \
  ! -name '*.g.dart' \
  ! -name '*.freezed.dart' \
  ! -name '*.gen.dart' \
  ! -name '*.gr.dart' \
  -type f)

if [ -z "$files" ]; then
  echo "No source files found to check."
  exit 0
fi

echo "$files" | xargs dart format --line-length=120 --set-exit-if-changed

echo "Format check passed."
