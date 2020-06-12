function gitignore {
  str=$1;

  touch .gitignore;

  # if grep -q $str .gitignore; then
  #   echo "File already ignored."
  #   return 0;
  # fi

  echo $str >> .gitignore;
}
