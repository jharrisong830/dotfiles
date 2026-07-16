---
name: review-report
description: Run a full-codebase review using the code-reviewer agent and write the findings to REVIEW.md in the project root. Use when the user asks for a full code review report, a pre-merge quality pass, or wants a REVIEW.md generated for a later walkthrough.
argument-hint: [optional focus areas or notes for the reviewer]
---

1. Determine the project root (git root, or current working directory if it is not a git repository).
2. If `<project root>/REVIEW.md` already exists, back it up by renaming it to `REVIEW-<YYYY-MM-DD>.md` using today's date before proceeding. If a backup with that name already exists too, overwrite it.
3. Run the configured `code-reviewer` agent. Instruct it to:
   - Review all non-ignored source files under the project root.
   - Return its findings in a structured format: a one-paragraph summary at the top, findings grouped by file with `[Category] Title`, severity, file/line, issue description, suggested change, and why it is better; a "Positive Observations" section; a "Priority Action Items" list; and a "Files Reviewed" list.
   - If `$ARGUMENTS` is non-empty, use it as additional focus areas or notes for the review.
4. After the agent returns, write its report verbatim to `<project root>/REVIEW.md` using the available file-editing mechanism. Do not ask the reviewer to write the file itself.
5. Confirm that the file was written, then report a brief summary to the user, such as the finding count by severity. Mention that the `review-walkthrough` skill can step through the report's findings one at a time with explanations and proposed fixes. Do not invoke it automatically.

$ARGUMENTS
