#!/usr/bin/env bash

input=$(cat)

IFS=$'\t' read -r MODEL PCT USED TOTAL < <(echo "$input" | jq -r '[
    .model.display_name,
    ((.context_window.used_percentage // 0) | floor | tostring),
    ((.context_window.current_usage.input_tokens // 0)
     + (.context_window.current_usage.output_tokens // 0)
     + (.context_window.current_usage.cache_creation_input_tokens // 0)
     + (.context_window.current_usage.cache_read_input_tokens // 0) | tostring),
    (.context_window.context_window_size // 0 | tostring)
] | join("\t")')
PCT=${PCT:-0}

DIR="${PWD/#$HOME/~}"
DIR="${DIR##*/}"

HOST=$(hostname -s)

GIT_BRANCH=$(git branch --show-current 2>/dev/null)

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

BRANCH_STR=""
BRANCH_ICON=$(printf "\xef\x90\x98")
[ -n "$GIT_BRANCH" ] && BRANCH_STR=" ${MAGENTA}${BRANCH_ICON} ${GIT_BRANCH}${RESET}"

printf "${RED}${MODEL}${RESET} @ ${GREEN}${HOST}${RESET}: ${BLUE}${DIR}${RESET}${BRANCH_STR}\n"
printf "${BAR_COLOR}${FILLED_BAR}${DIM}${EMPTY_BAR}${RESET} ${BAR_COLOR}${PCT}%%${RESET} ${DIM}${USED_FMT}/${TOTAL_FMT}${RESET}"
