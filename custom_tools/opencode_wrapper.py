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
