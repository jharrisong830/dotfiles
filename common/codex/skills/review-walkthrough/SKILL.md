---
name: review-walkthrough
description: Walk through findings in a REVIEW.md code review report one at a time, explaining each issue and proposing a fix, pausing for approval before applying. Use when the user wants to work through an existing code review report finding by finding.
argument-hint: [path to REVIEW.md; defaults to ./REVIEW.md at the project root]
---

Run this entirely in the current Codex conversation. Each finding requires pausing for the user's decision before continuing.

1. Locate the report: use the path in `$ARGUMENTS` if given, otherwise `REVIEW.md` at the project root (git root, or current working directory if it is not a git repository). If no report is found, say so and suggest running `review-report` first, then stop.
2. Read the report and parse it into an ordered list of individual findings (each `[Category] Title` block: file/location, severity, issue, suggested change, and why it is better). Keep the "Positive Observations" and "Files Reviewed" sections in mind for context but do not treat them as findings to walk through.
3. Go through findings one at a time, in the order they appear in the report. For each one:
   - State the file/location and severity.
   - Explain the issue in your own words, what is wrong and why it matters, rather than just repeating the report text verbatim.
   - Propose the concrete fix.
   - Ask the user whether to apply it, skip it, or adjust it, then stop and wait for their reply before doing anything else.
   - Only after the user responds: apply the edit if approved, move on if skipped, or revise the proposal if they want changes and reconfirm before applying.
4. Track applied versus skipped findings as you go.
5. After the last finding, give a short summary of what was applied and what was skipped. Do not modify `REVIEW.md` itself.

$ARGUMENTS
