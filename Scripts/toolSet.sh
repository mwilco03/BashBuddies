curl -sfKL https://raw.githubusercontent.com/mwilco03/BashBuddies/main/Notes.md  | grep \*\*Command | grep -vE '^\#\#' |cut -d'`' -f2|cut -d'|' -f2|tail -n +2|awk '!a[$1]++ {print $1}'
