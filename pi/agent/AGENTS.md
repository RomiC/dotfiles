# Pi Agent Global Instructions

## Commit & Publish Safety Rules

- **Never run `git commit` without first showing me the full `git diff --staged` output** and getting
  my explicit approval of the commit message and changed files.
- **Never run `git push`, `git push --force`, or `git tag`** without explicit approval.
- **Never create, merge, close, or edit a PR** (`gh pr create`, `gh pr merge`, `gh pr close`,
  `gh pr edit`) without showing me the full diff and PR description for review first.
- **Never post comments or reviews on my behalf** (`gh issue comment`, `gh pr comment`,
  `gh pr review`) without showing me the exact text and getting explicit approval.
- Read-only PR commands (`gh pr view`, `gh pr list`, `gh pr status`, `gh pr diff`) are fine to
  run without asking.
- **Never create or publish a release** (`gh release create`, `gh release publish`) without
  explicit approval.
- **Never publish packages** (`npm publish`, `yarn publish`, `pnpm publish`, `cargo publish`)
  without explicit approval.

## Code Comments

- Comment ONLY non-trivial code — parts that might confuse or that have research and decisions behind them.
- Comments MUST NOT exceed 2 lines — longer comments are garbage left for stupid AI agents.
- Instead of commenting code, check and update the related design documents.

## General Workflow

- When preparing a commit, first stage changes, then show `git diff --staged`, then propose a
  commit message — and wait for me to say "go ahead" before running `git commit`.
- When preparing a PR, show me the branch diff and the draft PR title + body before creating it.
- If unsure whether an action is reversible, ask before executing.
