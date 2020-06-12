# List Starting With Name
function lsn {
  path=$1;

  find . -maxdepth 1 -iname "$1*" -print
}
