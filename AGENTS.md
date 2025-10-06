# UI-TARS Desktop Project Agents

This pnpm monorepo hosts AI agents for GUI automation using vision-language models, including Agent TARS and UI-TARS Desktop app.

## Commands

- **Build**: `turbo run ui-tars-desktop#build` or `pnpm dev:ui-tars` for dev.
- **Lint**: `pnpm lint` (ESLint with TS/React rules, mostly relaxed).
- **Test**: `pnpm test` (Vitest); run single test with `vitest run path/to/test.ts`.
- **Format**: `pnpm format` (Prettier with single quotes, semicolons, trailing commas).
- **Typecheck**: `turbo run typecheck`.

## Safety & Quality Features

- **Pre-commit Hooks**: Automated checks via pre-commit framework (`.pre-commit-config.yaml`).
- **Backup System**: Intelligent file versioning (`./scripts/backup_file.sh <file>`).
- **Validation Suite**: Comprehensive testing (`./scripts/test_project.sh`).
- **Branch Protection**: No direct commits to main branch.
- **CI/CD**: GitHub Actions quality gates (`.github/workflows/quality.yml`).
- **Setup**: Run `./scripts/setup_safety.sh` to initialize safety features.

## Code Style

- **Imports**: Use absolute paths; sort with `@trivago/prettier-plugin-sort-imports` (commented in config).
- **Formatting**: Prettier: single quotes, semicolons, trailing commas, 2-space tabs.
- **Types**: TypeScript strict; explicit returns off, unused vars off.
- **Naming**: camelCase for vars/functions; PascalCase for classes/components.
- **Error Handling**: Use try/catch; no specific patterns enforced.
- **Other**: ESLint rules mostly off; follow React/TS best practices; modular architecture. No Cursor or Copilot rules.
