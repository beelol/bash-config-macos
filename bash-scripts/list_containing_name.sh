# List Containing Name
function lcn {
  path=$1;

  find . -maxdepth 1 -iname "*$1*" -print
}
