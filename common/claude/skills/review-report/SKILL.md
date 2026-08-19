---
name: review-report
description: Run a full-codebase review using the code-reviewer agent and write the findings to REVIEW.md in the project root. Use when the user asks for a full code review report, a pre-merge quality pass, or wants a REVIEW.md generated for a later walkthrough.
argument-hint: [optional focus areas or notes for the reviewer]
allowed-tools: Edit(/REVIEW*.md)
---

1. Determine the project root (git root, or current working directory if not a git repo).
2. If `<project root>/REVIEW.md` already exists, back it up before proceeding: `Read` its contents and `Write` them verbatim to `<project root>/REVIEW-<YYYY-MM-DD>.md` (today's date), overwriting that backup if it already exists. Use `Read`/`Write` for this, not `Bash(mv ...)` or similar — the backup and overwrite both need to land on `REVIEW*.md` filenames to stay covered by this skill's `allowed-tools` grant.
3. Spawn the `code-reviewer` agent via the Agent tool with `run_in_background: true`. The agent has no file-write tools — instruct it to return its complete findings as the text of its final response, not to write any file itself. Tell it to:
   - Review all non-ignored source files under the project root.
   - Return its findings in a structured format: a one-paragraph summary at the top, findings grouped by file with `[Category] Title`, severity, file/line, issue description, suggested change, and why it's better; a "Positive Observations" section; a "Priority Action Items" list; and a "Files Reviewed" list.
   - If `$ARGUMENTS` is non-empty, pass it along as additional focus areas or notes for the review.
4. You will be notified automatically when the agent finishes — do not poll or wait actively. In the meantime, continue with other work or respond to the user.
5. Once notified, take the agent's returned report text and write it verbatim to `<project root>/REVIEW.md` yourself using the Write tool. Confirm the file was written, then report a brief summary to the user (e.g. finding count by severity). Mention that the `review-walkthrough` skill can step through the report's findings one at a time with explanations and proposed fixes. Do not invoke it yourself.

$ARGUMENTS
