/*

 */
# Trae Agent Universal Rules
<!-- 15 000 bytes budget – keep it tight! -->
<!-- Last updated: 2025-10-07 -->

## Meta
- Language: English only (ISO-639-1 en)
- Encoding: UTF-8 without BOM
- Line endings: LF
- Max line length: 100 cols (soft)

## Agent Core Loop
1. **Plan → Validate → Execute → Verify → Record**
2. Never proceed to the next step while red diagnostics exist.
3. Prefer idempotent bash commands; always use `--dry-run` flags when available.
4. Always `cd` to `$PROJECT_ROOT` before any file or shell action.
5. Keep a running "Risk Log" comment block at the top of every modified file until PR is merged.

<!-- Risk Log: secretlint false positive workaround -->
# Code Quality Gates
quality gates:
- `ruff check --fix` (Python)
- `eslint --fix` (TS/JS)
- `go fmt` (Go)
- `cargo clippy --fix` (Rust)
- 100 % type-coverage enforced for TS (strict) & Python (`pyright --strict`).
- Unit-test coverage must not drop > 1 % per patch.
- No `TODO/FIXME` left in production paths; migrate to GitHub issue instead.

## Security & Compliance
- Never embed secrets in strings – always pull from `process.env` / `env_file`.
- Reject weak crypto (`md5`, `sha1`, `des`, `rc4`).
- Enforce least-privilege file modes (`0600` for secrets, `0755` for executables).
- Dependency bumps require `pip-audit` / `npm audit` / `osv-scanner` green exit code.

## Performance Budget
- Cold-start ≤ 200 ms (measured via `hyperfine`).
- Bundle size delta ≤ +3 % for web assets.
- SQL N+1 queries forbidden – always `select_related` / `prefetch_related` (Django) or equivalent.

## Git Hygiene
- One logical change → one commit.
- Commit title ≤ 50 chars, imperative mood, no period.
- Body wrapped at 72 cols; reference issue `#123` at footer.
- Use `git range-diff` before force-push to preserve review history.

## Tool Calling Conventions
- `str_replace_based_edit_tool`: always emit unified-diff style hunk markers.
- `bash`: prepend `set -euo pipefail` and print command with `+ ` prefix.
- `task_done`: only when trunk is green and patch verified e2e.
- `sequentialthinking`: output JSON with keys `thought`, `reason`, `next_action`.

## Prompt Engineering
- Keep system prompts ≤ 2 k tokens; offload examples into `fewshot/` YAML files.
- Prefer chain-of-thought over inline XML tags (token efficiency).
- Use structured output (`json_schema`) whenever downstream code consumes it.

## Telemetry & Privacy
- Log only non-PII; hash user identifiers with BLAKE3.
- Rotate logs daily; compress with zstd; retain 30 d.
- Provide `do-not-track` env var opt-out.

## Abandoned Patterns
- No default exports in TS (use named exports for tree-shaking).
- No `any`/`interface{}` – replace with branded types.
- No `shell=True` in Python subprocess calls.
- No `console.log` in production – use structured logger.

## Emergency Escape Hatch
If CI is red > 30 min on `main`, create empty commit with `[EMERGENCY SKIP]` and file incident within 5 min.
