# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A personal dotfiles repository. There is no build/lint/test tooling — it is config files plus a declarative
manifest telling a dotfile-manager tool where each file should be linked on disk. The manager itself
(`bdfm`/`sdfm`, referenced under `common/bdfm` and `common/sdfm`) is external and not part of this repo; this
repo only holds its config (`config.yaml`) and the files it manages.

Initial setup after cloning: `git submodule update --init --recursive` (also available as
`post-install/git-submodule.sh`), which pulls in `unix/zsh/plugins/zsh-syntax-highlighting`.

## Layout

Top-level directories group configs by OS scope:

- `common/` — cross-platform tool configs (claude, codex, git, js/prettier/npm/bun, nvim, alacritty, btop,
  ghostty, vscodium, zed)
- `unix/` — zsh and yay (Arch package manager) configs, Unix-only
- `macos/` — iTerm2 and Terminal.app configs
- `windows/` — PowerShell profile, Windows Terminal, winget settings

Each tool lives in its own subdirectory containing the actual config file(s) plus a `.dotfiles` manifest.

## The `.dotfiles` manifest format

Every directory whose contents should be linked into place has a `.dotfiles` file: one or more YAML-ish blocks
separated by `---`, each describing one file/directory to link:

```
---
name: "settings.json"
location: "{HOME}/.claude/{NAME}"
win32:
  shouldLink: true
  location: "{HOME}/AppData/Roaming/Foo/{NAME}"
darwin:
  shouldLink: false
---
```

- `name` — the file/dir in this repo to link (often reused verbatim into `location` via `{NAME}`)
- `location` — target path on disk; `{HOME}` and `{NAME}` are template variables
- Per-OS overrides (`darwin:`, `linux:`, `win32:`) can change `location` or set `shouldLink: false` to skip
  linking on that platform
- `name` can differ from the target filename — e.g. `common/claude/.dotfiles` maps `CLAUDE-code.md` to
  `{HOME}/.claude/CLAUDE.md`, and `common/claude/skills/.dotfiles` maps skill directories from
  `common/claude/skills/*` to `{HOME}/.claude/skills/*`
- Commented-out blocks (`# name: ...`) are configs staged in the repo but intentionally not linked yet (see
  `common/alacritty/.dotfiles`, `common/bdfm/.dotfiles`, `common/zed/.dotfiles`)

When adding a new managed file, add or extend the `.dotfiles` block in that directory rather than inventing a
new mechanism, and match the existing per-OS override style.

## Claude Code / Codex configs are dogfooded here

`common/claude/` and `common/codex/` hold this user's actual global Claude Code and Codex CLI configuration,
symlinked to `~/.claude` and `~/.codex`. They are kept in parallel:

- `common/claude/CLAUDE-code.md` -> `~/.claude/CLAUDE.md`, `common/codex/AGENTS.md` -> `~/.codex/AGENTS.md` —
  equivalent global instructions for each tool
- `common/claude/agents/*.md` and `common/codex/agents/*.toml` — the same subagents defined per tool's native
  format
- `common/claude/skills/*` and `common/codex/skills/*` — the same skills mirrored for both tools

When editing one tool's agent/skill/instructions, check whether the equivalent under the other tool needs the
same change to stay in sync.
