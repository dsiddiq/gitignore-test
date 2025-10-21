#!/bin/bash
echo "🔍 Running sensitive info check..."

# Get the list of files staged for commit (only those, nothing else)
FILES=$(git diff --cached --name-only --diff-filter=ACM | grep -E '\.(py|R|ipynb)$')

if [ -z "$FILES" ]; then
  echo "✅ No Python/R/Notebook files staged — skipping sensitive check."
  exit 0
fi

declare -a PATTERNS_AND_LABELS=(
  'password\s*=::Possible Password'
  'api[_-]?key\s*=::Possible API Key'
  'Authorization::Possible Authorization Header'
  'Bearer\s+[A-Za-z0-9_-]{10,}::Possible Bearer Token'
  '(/Users/|C:\\\\Users\\\\)::Possible Hard-coded Path'
  'db_username\s*=::Possible Username'
  'db_password\s*=::Possible Password'
  'secret\s*=::Possible Secret or Key'
  'token\s*=::Possible Token'
)

FAIL=0

for file in $FILES; do
  if [ ! -f "$file" ]; then
    continue
  fi

  for pair in "${PATTERNS_AND_LABELS[@]}"; do
    pattern="${pair%%::*}"      # extract text before '::'
    label="${pair##*::}"        # extract text after '::'

    if grep -E -i "$pattern" "$file" > /dev/null; then
      echo "❌ Found suspicious pattern in $file: $label"
      FAIL=1
    fi
  done
done

if [ $FAIL -ne 0 ]; then
  echo "🚫 Commit aborted: remove sensitive info before committing."
  exit 1
else
  echo "✅ All checks passed — proceeding with commit."
fi
