# Generate a pseudorandom string.
function rstring() {
  LC_CTYPE=C tr -dc A-Za-z0-9 < /dev/urandom | fold -w "${1:-32}" | head -n 1
}

# Conveniently extract an archive.
function extract() {
  if [ "$#" -ne 1 ]; then
    printf "Usage: %s FILE" "$0" >&2
    return 1
  elif [ ! -f "$1" ]; then
    printf "File not found: %s\n" "$1" >&2
    return 1
  fi

  local name="${1%%.*}"
  local extension="${1#*.}"

  case "$extension" in
    lrz)     lrztar -d "$1" ;;
    tar.bz2) tar xjf "$1" ;;
    tar.gz)  tar xzf "$1" ;;
    tar.xz)  tar Jxf "$1" ;;
    bz2)     bunzip2 "$1" ;;
    gz)      gunzip "$1" ;;
    xz)      tar xvJf "$1" ;;
    tar)     tar xf "$1" ;;
    tbz2)    tar xjf "$1" ;;
    tgz)     tar xzf "$1" ;;
    zip|7z)  7z x "$1" ;;
    Z)       uncompress "$1" ;;
    rar)     unrar x "$1" ;;
    *)       printf "Unrecognized file extension: %s\n" "$extension" >&2
             return 1 ;;
  esac

  local ret=$?

  if [ "$ret" -eq "0" ] && [ -d "$name" ]; then
    cd "$name" || return 1
  fi

  return $ret
}

function upto() {
  if [ -z "$1" ]; then
    return
  fi
  local upto=$1
  cd "${PWD/\/$upto\/*//$upto}" || exit
}

function _upto() {
  local cur=${COMP_WORDS[COMP_CWORD]}
  local d=${PWD//\//\ }
  mapfile -t COMPREPLY < <(compgen -W "$d" -- "$cur")
}

complete -F _upto upto

# Colorise man pages.
function man() {
  env \
  LESS_TERMCAP_md=$'\e[0;33m'    \
  LESS_TERMCAP_me=$'\e[0m'       \
  LESS_TERMCAP_so=$'\e[1;31;34m' \
  LESS_TERMCAP_se=$'\e[0m'       \
  LESS_TERMCAP_us=$'\e[0;32m'    \
  LESS_TERMCAP_ue=$'\e[0m'       \
  man "$@"
}
