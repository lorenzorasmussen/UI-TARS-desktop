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
