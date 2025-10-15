# gitignore-test
testing gitignore tp catch bad code

## 🧩 Pre-commit Hook Setup

This repository uses [pre-commit](https://pre-commit.com) to automatically check for:
- Hardcoded passwords, API keys, and local paths  
- Coding standards (whitespace, end-of-file, merge conflicts)
- Secret detection with Gitleaks (via GitHub Actions)

### 🪄 One-time setup

After cloning the repo, run:

```bash
pip install pre-commit
pre-commit install

