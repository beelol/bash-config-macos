# cd into a directory, creating it (and any parent dirs) if it doesn't exist
cdm() {
  if [ -z "$1" ]; then
    echo "usage: cdm <path>" >&2
    return 1
  fi
  mkdir -p "$1" && cd "$1"
}
