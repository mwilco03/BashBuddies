#!/usr/bin/env bash

Usage() { cat <<EOF
COMMAND:
   ${0##*\/} - rummager of .shell_historys
USAGE:
   \`${0##*\/} [-OPTIONS] \`
DESCRIPTION:
  ( conchology:   history of [sea]shells )
OPTIONAL PARAMETERS:
   -h,                Show this information.
    --help
   -C <>,             Set number of context lines to <>.
    --context[= ]<>
   -S <>,             Set the name of the shell who's history
    --shell[= ]<>      you'd like to rummage to <>.
   -R,                Tell fzf not to reverse the input.
    --reverse         (omit if searching for most recent entry)
EOF
  exit 0
}
[[ "$1" != +(\-)@([hH])?([eE][lL][pP]) ]] || Usage

conchology() {
  # localize ctx as an int
  local -i ctx=$2
  # select a line of interest from a shell's history file
  local -i ln=$(cat -n "$1" | fzf $3 | awk '{print $1}')
  # output said line of interest wrapped in conext lines
  sed -n "$((ln-ctx)),$((ln+ctx))~${ctx}p" "$1"
}

# superior arg parsing
for ((a=1;a<=$#;a++)); do
  case "${!a}" in
  \-[cC]|'--context'*) [[ "${!a}" == *\=* ]] || ((++a)) ; context="${!a/*\=/}" ;;
  \-[sS]|'--shell'*) [[ "${!a}" == *\=* ]] || ((++a)) ; subject="$HOME/.${!a/*\=/}_history" ;;
  \-[rR]|'--reverse') FZF_OPTS+="--reverse " ;;
  *) continue
  esac
done

conchology "${subject:-$(ls -A1p ~/\.[a-zA-Z]*_history | grep -v '/$' | shuf -n1)}" ${context:-1} ${FZF_OPTS:-}
