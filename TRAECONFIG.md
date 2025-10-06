/*

 */
# Trae Agent Configuration for UI-TARS-desktop

This repository is configured with advanced Trae Agent rules and tools for optimal AI-assisted development.

## Setup Instructions

### 1. Configure Free Model API Keys

Run the setup script to configure your free model API keys:

```bash
./setup_free_models.sh
```

Then visit each provider to get your free API keys:
- **Google AI Studio**: https://makersuite.google.com/app/apikey (1M tokens/min free)
- **Groq**: https://console.groq.com (300+ tokens/sec free)
- **OpenRouter**: https://openrouter.ai/keys (free tier models)
- **DeepSeek**: https://platform.deepseek.com (generous free tier)
- **Hugging Face**: https://huggingface.co/settings/tokens (300+ free models)

### 2. Configure Trae Agent

The main configuration is in `trae_config.yaml` with:
- Model provider configurations for all free tiers
- MCP server setups for local tools
- Custom tool wrappers for Specify and OpenCode

### 3. Rules Structure

- **Global Rules**: `.trae/rules/trae_agents.md` - Universal Trae Agent rules
- **Project Rules**: `.trae/rules/project_rules.md` - Agent-TARS specific overrides
- **Custom Rules**: `.rules/project_rules.md` - This project's specific rules

### 4. Custom Tools

Located in `custom_tools/`:
- `specify_wrapper.py` - Integration with Specify design system
- `opencode_wrapper.py` - Integration with OpenCode (archived, use Crush alternative)

### 5. MCP Servers

Configured MCP servers include:
- **Specify**: Design system integration
- **Filesystem**: Local file operations
- **Git**: Version control operations
- **GitHub**: GitHub API integration

## Usage

1. Start Trae Agent with the configuration
2. Use the configured models within their free tier limits
3. Leverage MCP servers for enhanced functionality
4. Follow the established coding standards and rules

## Model Selection Guide

- **Fast queries**: Use Gemini 2.5 Flash
- **Complex analysis**: Use DeepSeek V3
- **Code generation**: Use Llama 4 Scout via OpenRouter free tier
- **Stay within free tier limits** to avoid charges

## Security Notes

- Never commit API keys to the repository
- Use environment variables for all sensitive data
- Follow the security guidelines in the rules files

## Troubleshooting

- Check MCP server connections if tools aren't working
- Verify API key permissions for each provider
- Monitor token usage to stay within free tier limits
- Review the rules files for specific constraints

## Repository Tree Structure & Branch Purposes

This project is organized as a monorepo with several key branches and packages, each serving a distinct purpose:

- **cli**
  - Contains CLI tools for interacting with Agent-TARS and related agents.
  - Examples: `@agent-tars/cli`, `@tarko/agent-cli`, `@tarko/agent-ui-cli`
  - Purpose: Provides command-line interfaces for agent operations, automation, and replay generation.

- **desktop**
  - Contains the desktop application (UI-TARS Desktop).
  - Examples: Electron main process, Vue renderer, Rust core, Python adapters.
  - Purpose: Delivers a native GUI agent experience for desktop environments, integrating vision and LLM capabilities.

- **sdk**
  - Example: `@ui-tars/sdk`
  - Purpose: Offers a cross-platform toolkit for building GUI automation agents, usable by both CLI and desktop apps.

- **agent**
  - Examples: `agent-tars`, `gui-agent`, `omni-tars`
  - Purpose: Houses the core agent logic, multimodal capabilities, and MCP tool integrations.

- **operator-browser**
  - Example: `@gui-agent/operator-browser`
  - Purpose: Implements browser automation and operator logic for GUI agents.

- **shared/utils**
  - Purpose: Shared utility libraries and types used across CLI, desktop, and agent packages.

- **other branches/packages**
  - Examples: `benchmark`, `docs`, etc.
  - Purpose: Benchmarking, documentation, and support tooling.

---

This structure enables modular development and clear separation of concerns between CLI, desktop, agent logic, and supporting utilities.
