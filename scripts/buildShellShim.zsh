if [ $1 = "--rcfile" ]; then
  # the rcfile flag indicates that the --command option was used.
  # This means the shell should stay open after executing. So we remove the last line which contains 'exit'
  shift
  tmp="$(dirname $1)/tmp"
  sed '$d' $1 > $tmp
  mv $tmp $1
fi
echo -e "\nzsh" >> $1
bash $1
