#!/bin/bash
echo "🔍 Running sensitive info check..."

# Get the list of files staged for commit (only those, nothing else)
FILES=$(git diff --cached --name-only --diff-filter=ACM | grep -E '\.(py|R|ipynb)$')

if [ -z "$FILES" ]; then
  echo "✅ No Python/R/Notebook files staged — skipping sensitive check."
  exit 0
fi

PATTERNS=(
  'password\s*='
  'api[_-]?key\s*='
  'Authorization'
  'Bearer\s+[A-Za-z0-9_-]{10,}'
  '(/Users/|C:\\\\Users\\\\)'
  'db_username\s*='
  'db_password\s*='
  'secret\s*='
  'token\s*='
)

FAIL=0

for file in $FILES; do
  if [ ! -f "$file" ]; then
    continue
  fi
  for pattern in "${PATTERNS[@]}"; do
    if grep -E -i "$pattern" "$file" > /dev/null; then
      echo "❌ Found suspicious pattern in $file: $pattern"
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
