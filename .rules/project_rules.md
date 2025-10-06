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
