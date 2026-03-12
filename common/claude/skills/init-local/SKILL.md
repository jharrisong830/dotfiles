---
name: init-local
description: Generate a CLAUDE.local.md for the current project. Use this to initialize local-only Claude context that should not be committed to version control.
argument-hint: [any extra notes or context to include]
context: fork
agent: general-purpose
---

Analyze the current project and generate a `CLAUDE.local.md` file in the project root. This file is for local-only Claude context and must not be committed.

Follow these steps:

1. Explore the project structure: identify the language, runtime, build tool, test framework, and key entry points.
2. Read any existing README, `CLAUDE.local.md`, or documentation to understand the project's purpose.
3. Check whether `CLAUDE.local.md` already exists:
   - **First run (file does not exist):** Write `CLAUDE.local.md` from scratch using the structure below.
   - **Update run (file already exists):** Read the existing file carefully, then re-examine the project to identify what has changed or what the existing file got wrong or omitted. Rewrite the file to reflect the current state. Specifically:
     - Refresh any commands or paths that may have changed.
     - Add sections or details that are now relevant but were missing.
     - Remove or correct anything that is no longer accurate.
     - Preserve any manually written notes or context that are still valid — do not discard content just because you did not generate it.
     - Do not simply re-output the existing content unchanged; the goal is an accurate, up-to-date file.
4. Check `.gitignore` — if `CLAUDE.local.md` is not already listed, add it. If no `.gitignore` exists, create one with that entry.

Do not create or modify `CLAUDE.md`.

---

## CLAUDE.local.md structure

```
# <Project Name>

<One or two sentence description of what this project does.>

## Build & Run

<How to build and run the project, including relevant commands.>

## Testing

<How to run tests. Include the test framework and any important test conventions.>

## Project Structure

<Key directories and files, with a brief note on what each contains. Focus on what is non-obvious.>

## Conventions

<Any patterns, idioms, or conventions found in the codebase that are important for making consistent changes.>
```

Omit any section where there is nothing meaningful to say. Do not add placeholder text.

$ARGUMENTS
