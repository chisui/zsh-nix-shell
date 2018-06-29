if [ $1 = "--rcfile" ]; then
  # the rcfile flag indicates that the --command option was used.
  # This means the shell should stay open after executing. So we remove the last line which contains 'exit'
  shift
  echo "rcfile"
  tmp="$(cat $1)"
  echo ${tmp%exit} > $1
  echo "zsh" >> $1
fi
bash $1
