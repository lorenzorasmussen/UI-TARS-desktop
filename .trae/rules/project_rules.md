# Agent-TARS Project Rules
<!-- Overrides for https://github.com/bytedance/UI-TARS-desktop/tree/main/agent -->
<!-- Apply AFTER global trae_agents.md -->

## Project Context
Agent-TARS is a *multimodal GUI agent* that drives desktop, browser & terminal via vision + LLM.
Stack: TypeScript (Electron main), Rust (TARS-core), Python (CLI adapter), Vue (renderer).
Monorepo managed by `pnpm@9` + `cargo workspaces` + `pyproject.toml`.

## Critical Constraints
1. **Never** bump Electron major without security sign-off (CVE history).
2. **Never** enable `nodeIntegration` in renderer – use `contextBridge` only.
3. Native modules must ship pre-built binaries for `darwin-x64`, `darwin-arm64`, `win-x64`, `linux-x64`.
4. Keep renderer bundle < 2 MB gzipped ( Lighthouse score ≥ 95 ).

## Coding Standards
- TS: `strictest` + `exactOptionalPropertyTypes` + `noUncheckedIndexedAccess`.
- Rust: `#![forbid(unsafe_code)]` in `tars-core`; exceptions need `// SAFETY:` comment + review.
- Python: target 3.10+ only, use `asyncio.run()` pattern, no `setup.py` – pure `pyproject.toml`.
- Vue: Composition API + `<script setup lang="ts">` + `eslint-plugin-vue-scoped-css`.

## Dependency Rules
- approve list for `npm`: `@vueuse`, `vue`, `electron`, `vite`, `rust-addon` only.
- `cargo deny` must pass (advisories, licenses, bans).
- Python lock file is `uv.lock`; never commit `poetry.lock` or `requirements.txt`.

## Testing Matrix
| Layer | Command | Gate |
|---|---|---|
| unit (ts) | `pnpm test:unit` | ≥ 90 % stmts |
| e2e (playwright) | `pnpm test:e2e` | 0 flakes allowed |
| rust | `cargo nextest` | 100 % pass |
| python | `pytest agent/tests` | ≥ 85 % cov |

## MCP Integration
- MCP servers live in `agent/mcp/`.
- Each server must expose `manifest.json` with `capabilities.tools.listChanges`.
- Use `stdio` transport only (SSE disabled for security).
- Secrets pulled from `~/.config/agent-tars/secrets.toml` (age-encrypted).

## Vision Pipeline
- Screenshot capture: 1080p PNG ≤ 250 kB; strip metadata.
- OCR pre-filter: Tesseract `eng+chi_sim` fast model.
- Icon classification: ONNX model ≤ 10 MB INT8 quantized.
- Never store screenshots > 24 h; tmpfs mount at `/tmp/agent-vision`.

## Release Checklist (automated)
1. `pnpm changeset` consumed.
2. `Cargo.toml` version aligned with `package.json`.
3. `agent/pyproject.toml` version aligned.
4. Native binaries rebuilt on tag push (CI).
5. GitHub release notes auto-generated from changeset + PR labels.

## Telemetry Opt-in
- Default: off.
- When enabled, send `event_type`, `session_id`, `error_code` only – no screen pixels.
- Endpoint: `https://telemetry.agent-tars.dev/v1/beacon` (CDN edge).

## Incident Runbook
If GUI hangs > 5 s:
1. Capture renderer process stack (`electron --inspect`).
2. Dump GPU info (`chrome://gpu` equivalent).
3. Auto-open issue with template `.github/ISSUE_TEMPLATE/gpu_hang.yml`.

## Special Tool Directives
- `desktop_screenshot`: always mask password fields with black rectangle.
- `keyTap`: validate key code against `QWERTY` layout map; no raw keycodes.
- `shellExecute`: whitelist only `git`, `pnpm`, `cargo`, `python -m agent.cli`.
- `browserNavigate`: block `file://` protocol (XSS vector).

## Do-not's (TARS specific)
- Do not inject `<script>` tags into user pages.
- Do not download external drivers/binaries at runtime.
- Do not persist cookies across sessions (incognito only).
- Do not use `child_process.exec` – use `execFile` with absolute path.
