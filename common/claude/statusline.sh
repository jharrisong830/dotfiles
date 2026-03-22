#!/usr/bin/env bash

input=$(cat)

IFS=$'\t' read -r MODEL PCT USED TOTAL COST_RAW SESSION_ID < <(echo "$input" | jq -r '[
    .model.display_name,
    ((.context_window.used_percentage // 0) | floor | tostring),
    ((.context_window.current_usage.input_tokens // 0)
     + (.context_window.current_usage.output_tokens // 0)
     + (.context_window.current_usage.cache_creation_input_tokens // 0)
     + (.context_window.current_usage.cache_read_input_tokens // 0) | tostring),
    (.context_window.context_window_size // 0 | tostring),
    (.cost.total_cost_usd // 0 | tostring),
    (.session_id // "")
] | join("\t")')
PCT=${PCT:-0}

DIR="${PWD/#$HOME/~}"
DIR="${DIR##*/}"

HOST=$(hostname -s)

GIT_BRANCH=$(git branch --show-current 2>/dev/null)
GIT_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)

RESET=$'\033[0m'
DIM=$'\033[2m'
RED=$'\033[31m'
GREEN=$'\033[32m'
YELLOW=$'\033[33m'
BLUE=$'\033[34m'
MAGENTA=$'\033[35m'

if [ "$PCT" -ge 80 ]; then
    BAR_COLOR=$RED
elif [ "$PCT" -ge 60 ]; then
    BAR_COLOR=$YELLOW
else
    BAR_COLOR=$GREEN
fi

BAR_WIDTH=10
FILLED=$((PCT * BAR_WIDTH / 100))
EMPTY=$((BAR_WIDTH - FILLED))
FILLED_BAR=""
EMPTY_BAR=""
[ "$FILLED" -gt 0 ] && FILLED_BAR=$(printf "%${FILLED}s" | tr ' ' '▓')
[ "$EMPTY" -gt 0 ] && EMPTY_BAR=$(printf "%${EMPTY}s" | tr ' ' '░')

fmt_k() {
    local n=$1
    if [ "$n" -ge 1000 ]; then
        printf "%dk" $((n / 1000))
    else
        printf "%d" "$n"
    fi
}

USED_FMT=$(fmt_k "$USED")
TOTAL_FMT=$(fmt_k "$TOTAL")

COST=$(awk -v c="${COST_RAW:-0}" 'BEGIN {
    if (c < 0.01) printf "$%.4f", c
    else printf "$%.2f", c
}')

BRANCH_STR=""
BRANCH_ICON=$(printf "\xef\x90\x98")
[ -n "$GIT_BRANCH" ] && BRANCH_STR=" ${MAGENTA}${BRANCH_ICON} ${GIT_BRANCH}${RESET}"

SEP="${DIM}│${RESET}"

if [ -n "$SESSION_ID" ]; then
    mkdir -p "$HOME/.claude-usage"
    echo "$input" | jq -c --arg project "${GIT_ROOT:-}" '{
        session_id: .session_id,
        updated_at: (now | todate),
        model: .model.id,
        cwd: .cwd,
        project: (if $project != "" then $project else null end),
        cost_usd: (.cost.total_cost_usd // 0),
        duration_ms: (.cost.total_duration_ms // 0),
        lines_added: (.cost.total_lines_added // 0),
        lines_removed: (.cost.total_lines_removed // 0),
        context_window: {
            used_percentage: (.context_window.used_percentage // 0),
            size: (.context_window.context_window_size // 0)
        },
        tokens: {
            current: {
                input: (.context_window.current_usage.input_tokens // 0),
                output: (.context_window.current_usage.output_tokens // 0),
                cache_write: (.context_window.current_usage.cache_creation_input_tokens // 0),
                cache_read: (.context_window.current_usage.cache_read_input_tokens // 0)
            },
            total: {
                input: (.context_window.total_input_tokens // 0),
                output: (.context_window.total_output_tokens // 0)
            }
        }
    }' > "$HOME/.claude-usage/${SESSION_ID}.json"
fi

printf "${RED}${MODEL}${RESET} @ ${GREEN}${HOST}${RESET}: ${BLUE}${DIR}${RESET}${BRANCH_STR}\n"
printf "${BAR_COLOR}${FILLED_BAR}${DIM}${EMPTY_BAR}${RESET} ${BAR_COLOR}${PCT}%%${RESET} ${SEP} ${DIM}${USED_FMT}/${TOTAL_FMT}${RESET} ${SEP} ${DIM}${COST}${RESET}\n"
printf "${DIM}${SESSION_ID}${RESET}"
