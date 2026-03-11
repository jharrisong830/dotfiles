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
3. Write `CLAUDE.local.md` using the structure below. If `CLAUDE.local.md` already exists, use it as a starting point and update it with any new insights.
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
