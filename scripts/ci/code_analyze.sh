#!/bin/bash
cd "$(dirname "$0")/../.." || exit 1

exit_code=0

echo "Running flutter analyze..."
if ! flutter analyze; then
  exit_code=1
  echo "flutter analyze failed."
fi

echo "Running custom lint rules..."
if ! dart run custom_lint; then
  exit_code=1
  echo "custom_lint failed."
fi

if [ $exit_code -ne 0 ]; then
  echo "Code analysis failed."
  exit $exit_code
fi

echo "Code analysis passed."
