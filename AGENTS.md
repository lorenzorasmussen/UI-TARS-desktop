# UI-TARS Desktop Project Agents

This monorepo contains multiple AI agent implementations focused on GUI automation and multimodal interactions using vision-language models.

## Overview

The project is structured as a pnpm monorepo with turbo for build orchestration. It includes:

- **Agent TARS**: A comprehensive multimodal AI agent stack for controlling terminals, computers, browsers, and products through natural language and vision capabilities.
- **UI-TARS Desktop**: A native desktop application providing GUI agent functionality based on UI-TARS models.
- **Supporting Packages**: Infrastructure, SDKs, and shared utilities for agent development.

## Key Components

### Apps

- `apps/ui-tars`: Electron-based desktop application for UI-TARS Desktop.

### Packages

- `packages/agent-infra`: Core infrastructure for browser automation, logging, search, and shared utilities.
- `packages/ui-tars`: SDK, CLI, operators, and shared components for UI-TARS functionality.
- `packages/common`: Shared configurations and build tools.

### Multimodal Agents

- `multimodal/agent-tars`: Full agent stack with CLI, web UI, core logic, and MCP integration.
- `multimodal/gui-agent`: GUI agent implementations with action parsers and operators.
- `multimodal/omni-tars`: Extended agent framework with code and GUI agents.
- `multimodal/tarko`: Agent framework with CLI, server, UI builder, and various providers.

## Coding Patterns

- **Language**: TypeScript throughout the codebase.
- **Build System**: Turbo for monorepo orchestration, Vite for bundling.
- **Testing**: Vitest with coverage reporting.
- **Linting/Formatting**: ESLint and Prettier with custom configurations.
- **Package Management**: pnpm with workspace setup.
- **Desktop**: Electron with electron-vite for development.
- **Architecture**: Modular design with clear separation between core logic, interfaces, and implementations.

## Development Workflow

- Use `pnpm` for package management.
- Run `pnpm dev:ui-tars` for desktop app development.
- Use `pnpm test` for running tests.
- Follow conventional commits with husky pre-commit hooks.
- Use turbo for efficient builds across packages.
