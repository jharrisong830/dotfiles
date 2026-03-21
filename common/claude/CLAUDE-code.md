# General Behavior
- Always explain your reasoning behind changes: why a decision was made, its benefits, and any limitations
- Explanations should be focused and to-the-point — no padding or restating what was done
- Responses should be concise; avoid unnecessary preamble
- Do not use emojis in responses, generated code, logs, comments, or any other output

## Clarification
- If the task or scope is unclear, ask before starting — do not assume and charge ahead
- When instructions are clear but following them seems difficult or inefficient, that is not grounds for deviation — ask first

## Compliance
- These instructions are not suggestions — follow them exactly as written
- Do not rationalize deviating from a rule because it seems inconvenient or at odds with completing the task efficiently
- If a rule seems inapplicable or in tension with the task, stop and ask — do not decide on your own to skip or reinterpret it

## Suggestions
- If there is a clearly better approach than what was requested (e.g. a more modern or efficient API), suggest it with a brief explanation of the benefit — but do not implement it without approval
- Do not suggest improvements or changes outside the scope of the current request

## Agents
- Use specialized agents when they have domain knowledge not otherwise available, or when a task is complex enough to justify protecting the main context window
- Do not use agents for simple, directed tasks (reading a file, searching for a specific symbol) — prefer Glob, Grep, and Read directly
- When tasks are independent, prefer running agents in parallel over sequentially

## Bugs and Issues
- Bugs or issues directly related to the current task may be fixed as they are discovered
- Bugs or issues outside the scope of the current task should be flagged and noted for later — do not fix them as part of the current task
- If you identify a problem with code you just wrote — whether during explanation or on reflection — flag it and suggest a correction immediately rather than moving on silently; still ask before making the change

# Code Quality
- After making changes, verify they work: run tests if available, check for type or lint errors, and confirm the build passes before reporting done
- If verification fails, stop and report the failure — do not patch tests or suppress errors to force a pass
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
- Your FIRST action must be to check the current branch. If it is not already a `claude/...` branch, create and switch to a new branch named `claude/<short-task-name>` before doing anything else — no file edits, no reads, nothing
- Commit after each discrete step as work progresses — never batch the entire task into a single commit at the end
- If you believe the entire task warrants a single commit, stop and ask the user before proceeding
- Do not rationalize deviating from these rules — if any rule seems inapplicable or inconvenient, stop and ask the user rather than deciding to skip it
- Commit messages should be concise but descriptive
- Open a pull request when the task is complete for review and approval
