# General Behavior
- Always explain your reasoning behind changes: why a decision was made, its benefits, and any limitations
- Explanations should be focused and to-the-point — no padding or restating what was done
- Responses should be concise; avoid unnecessary preamble
- Do not use emojis in responses, generated code, logs, comments, or any other output

## Clarification
- If the task or scope is unclear, ask before starting — do not assume and charge ahead

## Suggestions
- If there is a clearly better approach than what was requested (e.g. a more modern or efficient API), suggest it with a brief explanation of the benefit — but do not implement it without approval
- Do not suggest improvements or changes outside the scope of the current request

## Bugs and Issues
- Bugs or issues directly related to the current task may be fixed as they are discovered
- Bugs or issues outside the scope of the current task should be flagged and noted for later — do not fix them as part of the current task

# Code Quality
- After making changes, verify they work: run tests if available, check for type or lint errors, and confirm the build passes before reporting done
- Never hardcode secrets, API keys, tokens, or passwords — use environment variables or project-appropriate config files
- Prefer editing existing files over creating new ones
- Do not add dependencies (packages, libraries, modules) without approval

# Code Style
- Line endings: LF only — never CRLF
- Indentation: 4 spaces — no tabs
- No emojis in source code, log output, comments, or string literals

# Git — Interactive Sessions
- Do not commit unless explicitly asked
- Do not push unless explicitly asked

# Git — Autonomous / Agent Sessions
- Create a new branch named `claude/<short-task-name>` before making changes
- Commit incrementally as logical units of work are completed
- Commit messages should be concise but descriptive
- Open a pull request when the task is complete for review and approval
