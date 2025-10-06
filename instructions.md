/*
Based on comprehensive research of the Trae Agent codebase, MCP integration, and free model options, here's a detailed prompt and setup guide for getting your project running with local tools and free models.

## Comprehensive Trae Agent Setup Prompt with MCP Integration

### System Prompt for Trae Agent

```markdown
# Trae Agent Configuration for Codebase Analysis & Local Tool Integration

You are an expert software engineering agent specializing in codebase analysis and implementation assistance. Your role is to help analyze the Trae Agent project codebase and integrate local development tools while using free LLM models.

## Core Capabilities

**Codebase Analysis**: Analyze code structure, dependencies, and architecture patterns in the Trae Agent repository
**Tool Integration**: Help implement and configure local tools including "specify", "opencode", and MCP servers
**Free Model Optimization**: Provide guidance on using free-tier LLM APIs efficiently
**Project Setup**: Guide through installation, configuration, and troubleshooting

## Available Tools

- **File System Tools**: Read, write, edit files using str_replace_based_edit_tool
- **Bash Execution**: Run commands, install dependencies, test configurations
- **Sequential Thinking**: Break down complex implementation tasks into logical steps
- **MCP Integration**: Connect external tools and data sources via Model Context Protocol

## Workflow Principles

1. Always use sequential thinking for multi-step tasks
2. Verify file contents before editing
3. Test configurations incrementally
4. Document all changes and setup steps
5. Prioritize free/open-source solutions
6. Use the most efficient free models for each task type

## Model Selection Strategy

- **Fast Tasks** (simple queries, file operations): Use Gemini 2.5 Flash or Groq Llama
- **Complex Analysis** (architecture review, debugging): Use DeepSeek V3 or Claude via OpenRouter
- **Code Generation**: Use Llama 4 Scout or Qwen models
- **Cost-Free Priority**: Always default to free-tier options
```

### Installation & Configuration Steps

**Step 1: Install Trae Agent**

```bash
# Clone the repository
git clone https://github.com/bytedance/trae-agent.git
cd trae-agent

# Install using UV (recommended package manager)
uv sync --all-extras
source .venv/bin/activate
```

**Step 2: Configure Free Model Providers**

Create `trae_config.yaml` with free model configurations:

```yaml
agents:
  trae_agent:
    enable_lakeview: true
    model: free_model_primary
    max_steps: 200
    tools:
      - bash
      - str_replace_based_edit_tool
      - sequentialthinking
      - task_done

model_providers:
  # Google AI Studio - 1M tokens/min free
  google:
    api_key: your_google_api_key
    provider: google

  # Groq - 300+ tokens/sec free
  groq:
    api_key: your_groq_api_key
    provider: openai
    base_url: https://api.groq.com/openai/v1

  # OpenRouter - free tier available
  openrouter:
    api_key: your_openrouter_api_key
    provider: openai
    base_url: https://openrouter.ai/api/v1

  # DeepSeek - generous free tier
  deepseek:
    api_key: your_deepseek_api_key
    provider: openai
    base_url: https://api.deepseek.com/v1

models:
  free_model_primary:
    model_provider: google
    model: gemini-2.5-flash
    max_tokens: 4096
    temperature: 0.5

  free_model_complex:
    model_provider: openrouter
    model: deepseek/deepseek-chat
    max_tokens: 8192
    temperature: 0.3

  free_model_fast:
    model_provider: groq
    model: llama-3.3-70b-versatile
    max_tokens: 2048
    temperature: 0.7
```

**Step 3: Set Up MCP Servers for Local Tools**

Add MCP configuration to `trae_config.yaml`:

```yaml
mcp_servers:
  # Specify tool integration
  specify_tool:
    command: npx
    args:
      - "-y"
      - "specify-mcp-server"
    env:
      WORKSPACE_PATH: "./workspace"

  # File system operations
  filesystem:
    command: npx
    args:
      - "@modelcontextprotocol/server-filesystem"
      - "/path/to/your/project"

  # Git operations
  git:
    command: npx
    args:
      - "@modelcontextprotocol/server-git"
      - "--repository"
      - "."

  # GitHub integration (if needed)
  github:
    command: npx
    args:
      - "@modelcontextprotocol/server-github"
    env:
      GITHUB_TOKEN: your_github_token
```

**Step 4: Create Custom Tool Wrappers**

Create `custom_tools/specify_wrapper.py`:

```python
"""
Wrapper for Specify tool to work with Trae Agent
"""
import subprocess
import json
from typing import Dict, Any

def run_specify(prompt: str, context_files: list = None) -> Dict[str, Any]:
    """
    Execute Specify tool with given prompt
    """
    cmd = ["specify", "generate"]
    cmd.extend(["--prompt", prompt])

    if context_files:
        for file in context_files:
            cmd.extend(["--context", file])

    result = subprocess.run(cmd, capture_output=True, text=True)

    return {
        "success": result.returncode == 0,
        "output": result.stdout,
        "error": result.stderr
    }
```

Create `custom_tools/opencode_wrapper.py`:

```python
"""
OpenCode integration for Trae Agent
"""
import subprocess
from pathlib import Path

def run_opencode_command(command: str, working_dir: str = ".") -> dict:
    """
    Execute OpenCode commands
    """
    # Note: OpenCode is now archived, use alternative Crush
    cmd = ["opencode", "-p", command, "-f", "json", "-q"]

    result = subprocess.run(
        cmd,
        cwd=working_dir,
        capture_output=True,
        text=True
    )

    return {
        "success": result.returncode == 0,
        "response": result.stdout,
        "error": result.stderr
    }
```

**Step 5: Create Project-Specific Rules**

Create `.rules/project_rules.md` in your project:

```markdown
# Project Rules for Trae Agent

## Codebase Analysis Guidelines

- Always check file structure before making changes
- Document architectural decisions
- Use type hints in Python code
- Follow PEP 8 style guidelines

## Tool Usage Priorities

1. Use MCP servers for external integrations
2. Prefer bash tool for system operations
3. Use str_replace_based_edit_tool for precise code modifications
4. Apply sequentialthinking for complex multi-step tasks

## Model Selection Rules

- Fast queries: Gemini 2.5 Flash
- Complex analysis: DeepSeek V3
- Code generation: Llama 4 Scout (via OpenRouter free tier)
- Stay within free tier limits

## Testing Requirements

- Test each configuration change incrementally
- Verify MCP server connections before use
- Document all API endpoints and credentials
```

### Free Model API Key Setup

**Google AI Studio** (1M tokens/min free):
- Visit: https://makersuite.google.com/app/apikey
- Create API key
- Set: `GOOGLE_API_KEY=your_key`

**Groq** (300+ tokens/sec free):
- Visit: https://console.groq.com
- Get API key
- Set: `GROQ_API_KEY=your_key`

**OpenRouter** (free tier models):
- Visit: https://openrouter.ai/keys
- Create account and key
- Set: `OPENROUTER_API_KEY=your_key`

**DeepSeek** (generous free tier):
- Visit: https://platform.deepseek.com
- Register and get API key
- Set: `DEEPSEEK_API_KEY=your_key`

**Hugging Face** (300+ free models):
- Visit: https://huggingface.co/settings/tokens
- Generate token
- Set: `HUGGINGFACE_TOKEN=your_token`

### Usage Commands

```bash
# Analyze Trae Agent codebase
trae-cli run "Analyze the architecture of the Trae Agent project and identify key components" --provider google --model gemini-2.5-flash

# Implement custom tool integration
trae-cli run "Help me integrate the Specify tool with MCP protocol" --provider openrouter --model deepseek/deepseek-chat

# Interactive mode with free model
trae-cli interactive --provider groq --model llama-3.3-70b-versatile

# Use MCP servers
trae-cli run "Use the filesystem MCP to analyze project structure" --working-dir /path/to/project

# Save analysis trajectory
trae-cli run "Document the Trae Agent tool ecosystem" --trajectory-file analysis.json --provider google --model gemini-2.5-flash
```

### Troubleshooting Common Issues

**Import Errors**:
```bash
PYTHONPATH=. trae-cli run "your task"
```

**API Key Issues**:
```bash
# Verify configuration
trae-cli show-config

# Test specific provider
echo $GOOGLE_API_KEY
```

**MCP Server Connection Issues**:
```bash
# Test MCP server manually
npx @modelcontextprotocol/server-filesystem /path/to/dir

# Check logs
tail -f ~/.trae/logs/mcp_server.log
```

### Recommended Free Model Usage Strategy

**Gemini 2.5 Flash**: Use for quick queries, file operations, and high-volume tasks (1M tokens/min)
**DeepSeek V3**: Best for complex reasoning, architecture analysis (77.9% MMLU, 128K context)
**Llama 3.3 70B (via Groq)**: Fastest inference for real-time responses (300+ tokens/sec)
**Llama 4 Scout (via Together AI)**: Best for large context needs (10M token window)
**Qwen 3 235B**: Excellent for multilingual codebases and documentation

This comprehensive setup enables full Trae Agent functionality with MCP integration and zero-cost model usage while maintaining production-quality capabilities.
 */
